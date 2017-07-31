#!/usr/bin/env python3

import sys
import io
from itertools import chain

from google.protobuf.compiler import plugin_pb2 as plugin
from google.protobuf.text_format import PrintMessage

class CodeGenerator:

    def __init__(self, tab="\t"):
        self.code = []
        self.tab = tab
        self.level = 0
        self.entities = {}

    def output(self):
        return '\n'.join(self.code)

    def write(self, string):
        fmt_str = string.format(locals())
        self.code.append(self.tab * self.level + fmt_str)
        return fmt_str

    def write_block(self, elements, writer):
        self.indent()
        for elem in elements:
            writer(elem,self)
        self.dedent()

    def indent(self):
        self.level = self.level + 1

    def dedent(self):
        self.level = max([0, self.level - 1])

def write_message(message, generator):
    generator.write("message {name}".format(name=message.name) + " {{")
    generator.write_block(message.nested_type, write_message)
    generator.write_block(message.enum_type, write_enum)
    generator.write_block(message.field, write_field)
    generator.write("}}")

def write_service(service, generator):
    generator.write("service {name}".format(name=service.name) + " {{")
    generator.write_block(service.method, write_method)
    generator.write("}}")

def write_method(method, generator):
    generator.write("rpc {name} ({input}) returns ({output})".format(
        name=method.name,
        input=get_unqualified_name(method.input_type),
        output=get_unqualified_name(method.output_type)) + "{{}}")

def write_field(field,generator):
    type_name = get_unqualified_name(field.type_name) or map_scalar_type(field.type)
    generator.write("{label}{type} {name} = {number};".format(
        label='repeated ' if field.label == 3 else '',
        type=type_name,
        name=field.name,
        number=field.number
    ))

def write_enum(enum,generator):
    generator.write("enum {name}".format(name=enum.name) + "{{")
    generator.write_block(enum.value, write_enum_value)
    generator.write("}}")

def write_enum_value(enum_value, generator):
    generator.write("{name} = {number}".format(
        name=enum_value.name,
        number=enum_value.number
    ))

def map_scalar_type(type_num):
    mapping = {
        1 : 'double',
        2 : 'float',
        3 : 'int64',
        4 : 'uint64',
        5 : 'int32',
        6 : 'int64',
        7 : 'fixed32',
        8 : 'bool',
        9 : 'string'
    }
    return mapping.get(type_num, type_num)

def get_unqualified_name(type_name):
    if type_name is None:
        return None
    return type_name.split('.')[-1]


if __name__ == '__main__':
    data = sys.stdin.buffer.read()
    request = plugin.CodeGeneratorRequest()
    request.ParseFromString(data)

    response = plugin.CodeGeneratorResponse()

    f = response.file.add()
    f.name = 'buda.proto'

    generator = CodeGenerator()

    generator.write("syntax = \"proto3\";")
    generator.write("package buda;")

    messages_seen = []
    services_seen = []
    for proto_file in request.proto_file:
        for item in proto_file.message_type:
            if item.name not in messages_seen:
                generator.write("")
                messages_seen.append(item.name)
                write_message(item, generator)
        for item in proto_file.service:
            if item.name not in services_seen:
                generator.write("")
                services_seen.append(item.name)
                write_service(item, generator)

    f.content = (generator.output())
    output = response.SerializeToString()
    sys.stdout.buffer.write(output)
