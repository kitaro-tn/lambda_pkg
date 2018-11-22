#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import argparse


class Cli():

    @property
    def parser(self):
        return self.__parser

    @property
    def args(self):
        return self.__args

    def __init__(self, parser_option, args_map):
        self.__parser = argparse.ArgumentParser(**parser_option)
        for args_option in args_map:
            self.__parser.add_argument(**args_option)
        self.__args = self.__parser.parse_args()

    def validate(self):
        pass

def arg_parse():
    parser = argparse.ArgumentParser(description="Description.")
    parser.add_argument("-e", "--env", help="Environment", default="develop")
    args = parser.parse_args()
    return (parser, args)

def main():
    """
        Author          :   tatsunorinishikori
        Since           :   2018-11-22
        Description     :
    """

    parser, args = arg_parse()
    exit(0)

if __name__ == "__main__":
    main()

