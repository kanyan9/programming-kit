===========
Makefile
===========

概述
=======
Makefile是Unix程序员构建C/C++项目的方式，相较于Windows下集成开发环境根据一系列复杂的设置配置项目构建文件，makefile直接存储在项目目录中是一个轻量级且易于修改的文本文件（语法确实复杂）。一个完整的makefile会描述用于项目构建过程的所有文件和设置，并将其与相应的库链接起来，从而简化命令行编译。

为什么使用makefile？
=====================
对于简单的C/C++项目，可以直接调用编译器进行编译，例如：

.. code-block:: bash

  $ gcc file1.c file2.c -o a -Wall -std=c99

在命令行输入gcc命令可以直接调用C编译器，可以添加 `-Wall` 用于警告或 `-std=c99` 使用C99规范等编译标志，或 `-o <name>` 来设置指定名称的可执行文件。

当项目变得复杂时，输入的gcc命令会变得非常复杂，而且很容易出错，在编译过程中也会因为各种原因反复重输代价大。这时使用makefile管理编译就会方便很多，可以一次编写多次复用，降低出错率和编写成本。

使用makefile非常简单，在命令行输入make命令调用make程序，该程序会从当前目录读区makefile文件，并执行必要的编译命令来编译默认目标。也可以只构建特定的目标，如 `make test` 。特殊目标 `make clean` 会删除任何先前已构建的产品。Makefile本身包含了构建所需信息，包括构建特定目标所需的步骤、目标的依赖关系、按什么顺序构建子产品以及向编译器传递什么编译标志等。

Makefile在编译时自动决定需要编译项目的哪些目标。有依赖关系图的makefile只会在目标所依赖的一个或多个组件发生变化时重新编译目标，如果依赖组件未发生任何变化则不会重新编译目标。这样的设计会提升编译的性能，节省编译时间。在小项目中这样的设计性能提升微乎其微，但在大型实际项目中，此类优化可以在每次构建项目时节省数小时的编译时间。

如何写makefile？
=====================
Makefile由一系列规则组成，规则样式如下：

.. code-block:: makefile

  target: dependencies ...
        command
        ...
        ...

目标（target）通常是程序生成的文件名，例如可执行文件或目标文件的文件名。目标也可以是要执行的操作的名称，而没有实际文件生成，如“clean”（详情参见.PHONY）。

依赖（dependencies）是用于创建目标的依赖文件，一个目标通常依赖多个文件。

命令（command）是make在构建时执行的一个操作。一个规则可能包含多条命令，命令可以在同一行也可以在不同的单独行。 **注意每个单独的命令必须用tab缩进**，如果你希望在命令前使用tab以外的字符，可以将.RECIPEPREFIX变量设置为其他字符。

为了满足实际工程中不同项目的编译要求，makefile文件还有许多其他的特性：
1. 变量赋值

.. code-block:: makefile

  CC := clang
  CXX := clang++  # 可通过make CXX=g++形式覆盖

  object := main.o

使用变量如下：

.. code-block:: makefile

  hello: $(object)
      $(CXX) -o $@ $(object)  # $@是自动变量表示target名

  main.o: main.cc
      $(CXX) -c main.cc

2. 自动推断
Make可以自动推断.o目标文件需要依赖同名的.cc文件，所以其实不需要在依赖中指定的.cc文件。但是Make无法自动推断头文件，所以需要指定目标所依赖的头文件，使得头文件变动时可以重新编译头文件对应的目标。

3. 伪目标（.PHONY）
.PHONY表示目标不会真实生成一个文件，而是一个“伪目标”或者一个操作的名称。一般情况下，我们编写的Makefile中会有这样一个目标 `clean`，执行 `make clean` 该目标会清除编译过程中产生的中间文件和生成的最终目标文件。

为了测试，这里编写一个简单的Makefile文件。该Makefile中并不提供编译源码的规则，只提供了一个clean目标，希望执行make clean时删除当前目录及子目录下所有的.o文件。

.. code-block:: makefile

  clean:
      rm $(shell find -name "*.o")

假设现在路径下有built-in.o、main.o、makefile这三个文件，执行 `make clean` 

.. code-block:: bash

  $ ls
  built-in.o    main.o    makefile
  $ make clean
  rm ./main.o ./built-in.o

目前一切顺利，执行make clean清除目录下所有的.o文件，达到了期望的效果。但是，假如此时路径中有built-in.o、main.o、clean、makefile这四个文件，执行 `make clean`

.. code-block:: bash

  $ ls 
  built-in.o    main.o    clean    makefile
  $ make clean
  make: 'clean' is up to date

到这里出现了问题，执行 `make clean` 并没有删除当前目录下所有的.o文件。出现这种现象原因是因为由于当前目录中有和clean目标同名的文件存在，makefile中clean目标也没有相关的依赖，make机制判断clean目标文件已经是最新的，则目标后面的命令（commands）永远不会被执行。

这种情况就和预期冲突了，我们想要的是无论clean目标是否存在，都应该执行clean目标下的命令。基于这种需求，就引入了makefile中的.PHONY（伪造）目标。

参考文件及扩展阅读
=====================

Stanford Guide to makefiles: https://web.stanford.edu/class/archive/cs/cs107/cs107.1174/guide_make.html

GNU make manual: https://www.gnu.org/software/make/manual/make.html#Reading