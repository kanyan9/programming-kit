======
GDB
======

概述
==========
GNU debugger（也被称为 **gdb**）是目前最常用的动态调试工具之一，你可以使用gdb调试C/C++程序，
如果想使用gdb调试其他语言编写的程序，可以在 `GDB文档`_ 中查询其支持的语言列表。

Gdb允许你查看另一个程序在执行时其“内部”发生了什么，或者另一个程序崩溃时正在做什么。Gdb可以指定
程序运行到某个点时停下来，查看此时程序中变量或表达式的值，也可以一行一行的运行程序，在每一行程序
执行完后打印出每个变量或表达式的值。

Gdb帮助你在执行过程中捕捉以下信息调试程序：
1. 如果程序运行时发生了核心转存（core dump）错误，是哪条语句引起的；
2. 如果在执行函数时发生错误，程序中哪一行包含了对该函数的调用，参数是什么；
3. 程序执行过程中在某个特定时刻，程序中变量的值是多少；
4. 程序中某个表达式的结果是什么。

GDB使用
================

GDB安装
-----------
在使用gdb进行调试前请安装gdb，很多Linux操作系统默认都已经安装了gdb，可输入以下命令查看gdb是否
已安装。

.. code-block:: bash

  $ gdb -v

如果显示未安装gdb，在Debian系统操作系统上使用以下命令进行安装。

.. code-block:: bash

  $ sudo apt install gdb

GDB调试
---------
在Linux机器上调试本地进程时，gdb依赖ptrace这个syscall，它从操作系统层面为gdb控制其他进程的运
行提供了基础支持。一般而言，出于安全性考虑，各个Linux发行版都对ptrace syscall的调用进行了程度
不等的权限控制。例如只允许通过ptrace调试子进程等。要用gdb调试程序，必须在编译程序时使用-g参数。
默认编译生成的可执行文件是无法使用gdb来跟踪或调试的，因为可执行文件中没有可供gdb调试使用的特殊信
息。在编译时使用-g参数，可在可执行文件中加入的 **符号表和调试信息**，支持gdb运行追踪调试程序。
使用如下命令编译程序生成可执行文件：

（注：下文中尖括号<>中的内容都可以根据实际情况进行替换）

.. code-block:: bash

  $ g++ <example.cc> -g -o <example>

启动gdb调试程序：

.. code-block:: bash

  $ gdb <example>
  GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1
  Copyright (C) 2022 Free Software Foundation, Inc.
  ...
  (gdb)

Gdb也允许调试一个正在运行的程序，通过运行程序的进程号pid，进入进程中（由于权限控制，可能需要
sudo权限）：

.. code-block:: bash

  $ sudo gdb --pid <pid_number>
  GNU gdb (Ubuntu 12.1-0ubuntu1~22.04) 12.1
  Copyright (C) 2022 Free Software Foundation, Inc.
  ...
  (gdb)

Gdb通过命令行交互调试程序，在（gdb）提示符后输入命令即可开始调试，gdb提供了大量的调试选项，可满
足大部分场景中代码调试的需要。

运行程序
*********
在gdb中使用 **run命令缩写为r** 来执行程序，如果程序运行时需要输入命令行参数，也可以像unix命令
行一样为程序提供命令行参数。

.. code-block:: bash

  (gdb) run <param1> <param2>

使用run命令运行程序时也可以对输入/输出进行重定向。

.. code-block:: bash

  (gdb) run > output.txt

断点
*********
断点是指在程序中暂时停止执行的位置，以便检查变量值或找出程序崩溃的原因等。

断点设置
~~~~~~~~~~
在gdb中设置断点，需要使用 **break命令缩写为b**。在函数开始处设置断点可使用 ``break function`` 
，如果代码包含在多个文件中，可能需要指定 ``break filename:function`` 。在源文件中给定的行号
处设置断点可使用 ``break linenumber`` 或 ``break filename:linenumber`` 。程序运行时将
在断点处停止运行。 

.. code-block:: bash

  (gdb) b <linenumber>
  (gdb) b <function> 

接续执行
~~~~~~~~~~~
程序在断点处停止运行后，想继续运行程序可使用 **continue命令缩写为c**，直到遇到下一个断点或程序
运行结束。

.. code-block:: bash

  (gdb) c

条件断点
~~~~~~~~~~
在设置断点时，我们可能希望当程序的执行满足某个条件时再触发断点停止运行，这时可使用条件断点命令，
条件断点和普通断点一样，只不过可以指定一些触发断点必须满足的条件，设置条件断点如下：

.. code-block:: bash

  (gdb) b <linenumber/function> if <condition>

或者

.. code-block:: bash

  (gdb) b <linenumber>
  (gdb) condition <linenumber> <condition>

断点清除
~~~~~~~~~~
在gdb中使用 **delete命令缩写为d** 会删除所有已设置的断点，可使用 ``delete number`` 删除编
号为number的断点，断点的编号可以通过 ``info breakpoints`` 命令获得。

其他
~~~~~~~~~
与设置断点类似的命令是 **until命令缩写为u** ，until命令可以指定程序运行到某一行停下来。

.. code-block:: bash

  (gdb) u <linenumber>

单步执行
*********
调试时有时需要单步执行程序，gdb中提供 **next命令缩写为n** 和 **step命令缩写为s** 支持单步执
行。

next命令单步执行时遇到子函数不会进入子函数体内单步执行，而是将子函数视为一步，在子函数执行完后再
停止。

.. code-block:: bash

  (gdb) n

next命令调试是源码级调试，如果不进入子函数想进行汇编级调试，查看下一条运行指令可使用 **nexti命令**。

step命令单步执行时遇到子函数会进入子函数继续单步执行程序。

.. code-block:: bash

  (gdb) s

step命令调试是源码级调试，如果进入子函数进行汇编级调试，查看下一条运行指令可使用 **stepi命令**。

如果单步执行已经进入了子函数，这时又不想在子函数中继续单步执行时，可以使用 **finish缩写为fi** 
退出该函数返回到调用它的函数中。

注：单步执行时遇到循环体，继续next命令回到循环的起点。如果不想循环的每个迭代都执行一遍可使用util
命令，使循环继续执行直到循环结束这样会方便循环体调试。

设置变量值
***********
程序运行时开发者可以为变量赋一个特定的值观察程序的行为和变化以调试程序，在gdb中使用 **set命令** 
在运行过程中设置某个变量的值。

.. code-block:: bash

  (gdb) set var varible::expr

显示信息
*************

打印变量
~~~~~~~~~~
在调试时我们需要查看程序运行过程中某个变量或表示式的值，在gdb中使用 **print命令缩写为p** 查看
变量或表达式的值。

.. code-block:: bash

  (gdb) print list[0]@7

上述的命令可查看名为list的数组的前7个值。

也可以使用 **display命令** 在程序每次停止时自动打印一个变量或表达式的值。

.. code-block:: bash

  (gdb) display var/expr

打印源代码
~~~~~~~~~~~
在gdb中调试代码时可以直接在交互命令行中打印出源码进行调试，使用 **list命令缩写为l** 可以查看源
代，一次只能打印10行代码。

.. code-block:: bash

  (gdb) list

可以指定一个数字参数来指定要显示哪一行周围的代码，例如：

.. code-block:: bash

  (gdb) list 8
  ...
  (gdb) list example::8

如果指定了文件名，那么显示的就是指定文件的代码，如果没有指定文件名，那么就是当前正在调试的文件。

打印栈信息
~~~~~~~~~~~
在调试时如果需要看到当前函数是如何一步步被调用的，可以使用 **backtrace命令缩写为bt** 显示栈跟
踪信息。

.. code-block:: bash

  (gdb) backtrace

但需要注意，由于编译器的优化等因素，如果没有调试信息，栈跟踪信息可能是不准确的，甚至无法提供栈跟
踪信息。

打印内存信息
~~~~~~~~~~~~
如果需要查看程序中内存中指定长度的内容，可使用 **examine命令缩写为x** ，与print命令不同，该命
令只能打印内存中的内容，且不需要如print一样将内存地址转换为指针并求值。这是因为此命令只是将内存
视为字节数组，打印出其中给定数目的字节的内容，而不对字节内容做任何解释。

.. code-block:: bash

  (gdb) x/<n/f/u> <address>

此命令中，N表示需要打印的单元数目，U的取值可以为b、h、w、g，分别表示一个单元大小为1、2、4、8字
节。F表示每个单元的打印格式，如i表示作为指令反汇编， x表示十六进制， d表示十进制等，详细信息可以
查看 `GDB文档`_ 。

查看程序状态信息
~~~~~~~~~~~~~~~~~
在gdb中可以使用 **info命令缩写为i** 来查看有关程序状态的信息，例如，上述使用 ``info breakpoints`` 
来查看程序断点信息，可以使用 ``info display`` 查看所有自动打印信息，使用 ``info locals`` 
查看当前函数中声明的所有本地变量的信息等。

观察点设置
~~~~~~~~~~~~
很多情况下，程序的bug是由于某个变量或地址被莫名修改而导致的，但是具体什么时候修改了该值，开发者很
难定位到。使用传统的方法只能一步一步去调试跟踪程序，调试效率低。在gdb中可以使用 **watch命令** 
设置观察点，监控变量或表达式值，一旦在运行过程中值发生了变化，程序就会停止，并输出旧变量值和新变
量值信息。使用观察点可以实现自动debug的作用。

.. code-block:: bash

  (gdb) watch var/expr

设置观察点后，当变量或表达式超出作用域被销毁，观察点也会随之删除，

退出gdb调试
************
可使用 **quit命令缩写为q** 退出gdb调试。

参考手册与扩展阅读
===================

.. _GDB文档:

GDB文档：https://sourceware.org/gdb/current/onlinedocs/gdb.html/index.html#SEC_Contents

卡内基梅隆大学GDB教程：https://www.cs.cmu.edu/~gilpin/tutorial/

密西根大学GDB教程：https://web.eecs.umich.edu/~sugih/pointers/summary.html

