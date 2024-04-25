==========
Shell
==========

概述
==========
现今我们在使用计算机时有多种交互方式可以控制计算机，从直观美观的图形用户界面（GUI）到语音输入Cortana（Windows语音助手）、siri（ios语音助手）等。这些交互方式覆盖大部分计算机使用场景，但是它们也显示了用户对计算机的操作——使用时不能点击一个不存在的图标或输入一个还没有被录入的语音指令。为了充分发挥计算机的能力，我们可以尝试回到最根本的计算机交互方式——shell。

Shell是一个C语言编写的程序，是Unix操作系统下用户和计算机交互的界面，用户在shell中输入文本，shell将文本转换为指令提供给操作系统内核运行。

接下来将以Bourne-Again shell（bash）为例说明shell的用法，bash被广泛使用，它的语法和其他的shell都是类似的。

.. TODO：terminal tty console shell kernel比较

使用shell之前需要打开terminal，一般计算机都已内置了终端。

Shell使用
============
打开终端是，一般情况下会看到一个提示符，如下：

.. code-block:: bash

  user@hostname:~$

这是shell最主要的文本接口，提示符显示此时使用shell的用户名和主机名，并且显示此时的工作目录（“current working directory”），工作目录是 `~` 表示 `home` 目录。 `$` 符号表示现在用户是普通用户不是root用户。

在这个提示符后，可以输入命令，shell解析命令并把命令发送给内核执行。例如：

.. code-block:: bash

  user@hostname:~$ echo hello world
  hello world
  user@hostname:~$

shell执行echo命令，同时指定参数hello world，echo程序将参数打印到标准输出上。Shell基于空格分割命令并进行解析，第一个单词代表程序，并将后续单词作为该程序的输入参数。如果输入的参数中包含空格，这是需要将参数放到双引号内，作为一个字符串输入。

在执行完命令后，shell会继续等待其他命令输入。

Shell如何知道echo命令代表什么含义呢？其实shell是一个编程环境，它也有变量、条件判断、循环和函数等内容（在shell编程中介绍）。当在shell中运行一个命令时，相当于写了一个程序让shell解释执行。如果执行的命令不是shell编程的关键字，它将会到名为 `$PATH` 的环境变量中搜索给定的命令对应的程序并执行。

.. code-block:: bash

  user@hostname:~$ echo $PATH
  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  user@hostname:~$ which echo
  /bin/echo
  user$hostname:~$ /bin/echo $PATH
  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

当shell执行 `echo` 命令时，shell会在 `$PATH` 中在一系列目录（目录间通过 `:` 分割）下，基于名称搜索 `echo` 对应的程序，找到该程序时便执行。确定某个命令对应的是哪个具体的程序时，可以使用 `which` 程序。实际执行命令时，也可以绕过 `$PATH` ，通过直接指定需要执行的程序的路径来执行该命令。

文件导航
------------
在Linux中文件目录由一系列使用 `/` 分割的字符串组成，Windows系统上是 `\` 分割的字符串。在Linux中单独 `/` 代表的是系统的根目录，所有的文件夹都包含在这个路径下，Windows中每个盘都有一个根目录例如： `C:\` 。下面主要以Linux文件系统为主讲解。如果某个路径以 `/` 开头，那么它是一个 **绝对路径** ，其他的是 **相对路径** 。相对路径是指相对于当前工作目录的路径，当前工作目录可以使用 `pwd` 命令来获取。在shell中可以使用 `ls` 和 `cd` 命令实现文件导航。

为了查看某个文件目录下包含哪些文件，可以使用 `ls` 命令：

.. code-block:: bash

  user@hostname:/$ ls
  bin   cdrom  etc   lib    lib64   lost+found  mnt  proc  run   snap  swapfile  tmp  var
  boot  dev    home  lib32  libx32  media       opt  root  sbin  srv   sys       usr

shell中大多数命令可以指定参数选项，参数以 `-` 开头，指定参数后会改变命令的行为。例如在 `ls` 命令后指定 `-l` 参数可以查看目录下文件的详细信息。

.. code-block:: bash

  user$hostname:/$ ls -l
  total 2097240
  drwxr-xr-x  20 root root       4096  3月  3 20:00 ./
  drwxr-xr-x  20 root root       4096  3月  3 20:00 ../
  lrwxrwxrwx   1 root root          7  3月  3 19:59 bin -> usr/bin/
  drwxr-xr-x   4 root root       4096  4月 10 09:28 boot/
  drwxrwxr-x   2 root root       4096  3月  3 20:00 cdrom/
  drwxr-xr-x  19 root root       4300  4月 15 13:01 dev/
  drwxr-xr-x 133 root root      12288  4月 15 13:09 etc/
  drwxr-xr-x   3 root root       4096  3月  3 20:01 home/
  lrwxrwxrwx   1 root root          7  3月  3 19:59 lib -> usr/lib/
  lrwxrwxrwx   1 root root          9  3月  3 19:59 lib32 -> usr/lib32/
  lrwxrwxrwx   1 root root          9  3月  3 19:59 lib64 -> usr/lib64/
  lrwxrwxrwx   1 root root         10  3月  3 19:59 libx32 -> usr/libx32/
  drwx------   2 root root      16384  3月  3 19:57 lost+found/
  drwxr-xr-x   4 root root       4096  3月  3 20:05 media/
  drwxr-xr-x   2 root root       4096  2月 23  2023 mnt/
  drwxr-xr-x   3 root root       4096  4月 10 15:47 opt/
  dr-xr-xr-x 391 root root          0  4月 15 13:01 proc/
  drwx------   4 root root       4096  4月 15 13:07 root/
  drwxr-xr-x  39 root root       1080  4月 15 15:23 run/
  lrwxrwxrwx   1 root root          8  3月  3 19:59 sbin -> usr/sbin/
  drwxr-xr-x  13 root root       4096  4月 10 09:28 snap/
  drwxr-xr-x   2 root root       4096  2月 23  2023 srv/
  -rw-------   1 root root 2147483648  3月  3 19:57 swapfile
  dr-xr-xr-x  13 root root          0  4月 15 13:01 sys/
  drwxrwxrwt  25 root root       4096  4月 15 15:23 tmp/
  drwxr-xr-x  14 root root       4096  2月 23  2023 usr/
  drwxr-xr-x  14 root root       4096  2月 23  2023 var/

文件详细信息中，第一个字符 d 表示是一个目录，字符 l 表示是一个链接，字符 - 表示是一个文件。然后接下来的九个字符，每三个字符构成一组。 r 代表有可读权限， w 代表有可写权限， x 代表有可执行权限。三组 rwx 分别代表了文件所有者（root），用户组（root） 以及其他所有人具有的权限。其中 - 表示该用户不具备相应的权限。

shell命令也支持简写， `ls -l` 命令可简写为 `ll` 。要了解某个命令有哪些参数选项可以使用 `-h` 或 `--help` 选项，打印命令帮助信息，以便了解命令的详细信息包括有哪些可用的参数选项等。

如果要切换到某个特定的目录下，可使用 `cd` 命令，例如：

.. code-block:: bash

  user@hostname:/$ cd /usr
  user@hostname:/usr$ ls
  bin  games  include  lib  lib32  lib64  libexec  libx32  local  sbin  share  src

在文件路径中有一些字符有特殊含义， `.` 表示的是当前目录，而 `..` 表示上级目录。

关于文件，还需要掌握几个常用的命令， `mv` 用于移动文件或重命名、 `cp` 用于拷贝文件、 `mkdir` 用于新建文件夹以及 `touch` 或 `vi` （Linux中常用的文本编辑器）用于新建一个文件等。

如果想要在使用时了解命令的工作方式，请试试 `man` 命令，它将其他命令作为参数，将其他命令的文档（用户手册）展示在标准输出上，使用 `q` 可以退出该命令。

命令间连接
-------------

重定向
***********
在shell中如果考虑从一个文件中获取命令的输入或将命令的输入导入到某个指定的文件中保存，而不是从标准输入获取输入和将命令的输出打印在标准输出，这时可以使用重定向命令。最简单的重定向是 `< file` 和 `> file` ，这两个命令可以将程序的输入输出重定向到文件：

.. code-block:: bash

  user@hostname:$ echo hello world > hello.txt
  user@hostname:$ cat hello.txt
  hello world
  user@hostname:$ cat < hello.txt
  hello world

`> file` 输出重定向往往会覆盖文件中的原始内容，如果想在原始内容的基础上追加写可使用 `>> file`。

管道
***********
重定向是将命令和文件连接起来，要想连接命令和命令可通过管道（pipes）， `|` 操作符表示一个管道可以将一个命令的输出和一个命令的输入连接起来，例如：

.. code-block:: bash

  user@hostname:/usr$ ls -l | tail -n1
  drwxr-xr-x   7 root root  4096  4月 10 09:28 src

字符串查找
--------------
Shell中可通过 `grep` 命令快速查找文件里符合条件的字符串或正则表达式。 `grep` 命令用法如下：

.. code-block:: bash

  grep [options] pattern [files]

- pattern：表示要查找的字符串或正则表达式
- files：表示要查找的文件名，可以查找多个文件，如果省略 files 参数，则默认从标准输入中读取数据。
- options：表示grep命令的参数，常用的参数包括-i（忽略大小写进行匹配）、-n（显示匹配行的行号）、-r（递归查找子目录中的文件）、-l（只打印匹配的文件名）、-c（只打印匹配的行数）等。

链接
------------
Shell中还有一个很重要的命令是 `ln` 命令，是link files的缩写，它的功能是为某一个文件在另外一个位置建立一个同步的链接。当用户在不同的目录用到相同的文件时，不需要在每个需要目录下都放置一个相同的文件，只要在某个固定的目录放置该文件，然后在其他目录下用 `ln` 命令链接（link）它就可以。所谓的链接，可以将其视为文件的别名，而链接又可分为两种 : 硬链接(hard link)与软链接(symbolic link)，硬链接的意思是一个文件可以有多个名称，而软链接的方式则是产生一个特殊的文件，该文件的内容是指向另一个文件的位置。硬链接和软链接只要有以下特点。

**软链接：**

- 以路径的形式存在类似于Windows操作系统中的快捷方式
- 可以跨文件系统
- 软链接可以对一个不存在的文件名进行链接
- 软链接可以对目录进行链接

**硬链接：**

- 以文件副本的形式存在。但不占用实际空间
- 不允许给目录创建硬链接
- 硬链接只有在同一个文件系统中才能创建

不论是硬链接或软链接都不会将原本的文件复制一份，只会占用非常少量的磁碟空间。

`ln` 命令用法如下：

.. code-block:: bash

  ln [options] [source file/dir] [dest file/dir]

其中source file/dir表示源文件或目录，dest file/dir表示目标文件或目录，options表示命令参数，必要的命令参数如下：

===========   ====================================
   参数              功能                              
===========   ====================================
 --backup       备份已存在的目标文件
 -b             类似--backup，但不接受参数
 -d             允许root用户制作目录的硬链接
 -f             强制执行
 -i             交互模式，文件存在则提示用户是否覆盖
 -n             把符号链接视为一般目录
 -s             软连接（符号连接）
 -v             显示详细的处理过程
===========   ====================================

根用户（Root User）
------------------------
在类Unix系统中有一类特殊的用户，被称为根用户（root user）。这类用户在系统使用过程中有最高权限，他不收任何限制，可以创建、读取、编辑和删除系统中的任何文件。通常情况下，使用系统时并不会以root身份直接登录系统，因为这样可能会因为某些错误的操作而直接破环系统。但有时又不得不使用root身份权限完成一些操作，这时可以使用 `sudo` 命令，它的作用就是让用户可以以su（super user或root）的身份执行一些操作。在系统使用过程中，当出现访问拒绝（permission dennied）的错误时，通常是因为权限不足，使用 `sudo` 命令，即可以root身份执行该操作。

Shell脚本
=============
Shell不仅仅是用户和内核交互的界面，也是控制系统的脚本语言，业界所说的shell通常都是指shell脚本，但本质shell和shell脚本是两个不同的概念。下面我们将专注于bash脚本，介绍shell脚本，因为它最流行且应用也更为广泛。

变量
-------------
在Shell编程中，变量是用于存储数据的名称，在bash中变量赋值的语法是 `foo=var` ，使用变量的语法是 `$foo`。需要注意的是 `foo=bar` 语句中不能使用空格隔开，也就是说 `foo = bar` 不能正常运行。因为解释器会将 `foo` 作为命令，并将 `=` 和 `var` 同时作为参数。Shell中变量名的命名须遵循如下规则：

- 只包含字母、数字和下划线，不能以数字开头；
- 避免使用shell脚本内置关键字如if、then、else、fi、for、while等；
- 使用大写字母表示常量，例如 `PI=3.14` ；
- 避免使用空格及其他特殊符号如@等。

有效的shell变量名如下：

.. code-block:: bash

  var='123'
  LD_LIBRARY_PATH="/bin/"

字符串
---------------
Bash中的字符串通过 `'` 和 `"` 来定义，但是他们表示含义并不相同，以 `'` 定义的字符串为原义字符串，其中的变量不会被转义，而 `"` 定义的字符串会将变量值进行替换。例如：

.. code-block:: bash

  foo=var
  echo "$foo" # 打印var
  echo '$foo' # 打印$foo

数组
---------------
数组中可以存放多个值，bash只支持一维数组，与C/C++不同bash初始化数组时不需要定义数组大小。bash数组用括号来表示，元素用空格分开，语法格式如下：

.. code-block:: bash

  arr=(var1 var2 ... varn)

一般通过 `${arr[index]}` 读取数组元素值。

流程控制
---------------
和其他编程语言一样，bash也支持if、case、while和for这些流程控制关键字。

if
************
if else语法格式如下：

.. code-block:: bash

  if condition
  then
      command1
      command2
  else
      command
  fi

if else-if else语法格式如下：

.. code-block:: bash

  if condition
  then
      command
  elif condition
      command
  else
      command
  fi

需要注意的是当使用 `[]` 和 `()` 作为condition时，括号内的语句要和括号用空格隔开，例如：

.. code-block:: bash

  [ $a == $b ]
  (( a > b))

for
************
for循环一般格式为：

.. code-block:: bash

  for var in item1 item2 ... itemN
  do
      command1
      command2
      ...
      commandN
  done

for循环从列表中取变量值，针对每个变量值执行一次所有命令。例如，顺序输出列表中数字：

.. code-block:: bash

  for var in 1 2 3 4 5
  do
      echo "value is $var"
  done

while
**************
while循环用于在满足判断条件的情况下不断执行一系列命令，也用于从输入文件中读取数据，其语法格式为：

.. code-block:: bash

  while condition
  do
      command
  done

将condition置为空值则为死循环。

case
***************
case ... esac 为多选择语句，与其他语言中的 switch ... case 语句类似，是一种多分支选择结构，每个 case 分支用右圆括号开始，用两个分号 ;; 表示 break，即执行结束，跳出整个 case ... esac 语句，esac（就是 case 反过来）作为结束标记。可以用 case 语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令。

case...esac语法格式如下：

.. code-block:: bash

  case var in
  var1)
      command1
      ...
  ;;
  var2)
      command2
      ...
  ;;
  ...
  *)
      commandN
  ;;
  esac

取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。

bash也支持使用 `break` 命令跳出所有循环，支持使用 `continue` 命令跳出本次循环。

函数
-----------
bash中可以自定义函数，然后在脚本中调用，函数语法如下：

.. code-block:: bash

  function function_name(){
      commands
      ...

      [return int;]
  }

或

.. code-block:: bash

  function_name() {
      commands
      ...

      [return int;]
  }

特殊变量及脚本运行
--------------------------
与其他脚本语言不同，bash使用了很多特殊的变量来表示传入参数、错误代码和相关变量。下面列举了常用的特殊变量，更多变量请参考 `Advanced Bash-Scripting Guide`_ 。

- $0：脚本名
- $1 到 $9：脚本的参数。 $1 是第一个参数，依此类推。
- $@：所有参数
- $#：参数个数
- $?：前一个命令的返回值
- $$：当前脚本的进程识别码
- !!：完整的上一条命令，包括参数。常见应用：当你因为权限不足执行命令失败时，可以使用 sudo !!再尝试一次。
- $_： 上一条命令的最后一个参数。如果你正在使用的是交互式 shell，你可以通过按下 Esc 之后键入 . 或者 Alt+ 来获取这个值。

命令通常使用 `STDOUT` 来返回输出值，使用 `STDERR` 来返回错误及错误码，以便于脚本以更友好的方式报告错误。返回码或退出状态是脚本与命令之间交流执行状态的方式。返回值为0表示执行正常，其他所有非0的返回值都表示有错误发生。

退出码可以搭配 `&&` （与操作符）和 `||` （或操作符）使用，用来进行条件判断，决定是否执行其他命令/程序。使用 `&&` 只有当第一个命令的退出状态码为0，后续命令才会执行，使用 `||` 时只有第一命令的退出状态码为非0，后续的命令才会执行。 命令 `true` 的返回码永远是0， `false` 的返回码永远是1。它们都属于短路运算符（short-circuiting）。同一行的多个命令可以用 `;` 分隔。以下是几个示例：

.. code-block:: bash

  false || echo "Oops, fail"
  # Oops, fail

  true || echo "Will not be printed"
  #

  true && echo "Things went well"
  # Things went well

  false && echo "Will not be printed"
  #

  false ; echo "This will always run"
  # This will always run

另一个常见的模式是以变量的形式获取一个命令的输出，这可以通过 **命令替换（command substitution）** 实现。当您通过 $( CMD ) 这样的方式来执行CMD 这个命令时，它的输出结果会替换掉 $( CMD ) 。例如，如果执行 for file in $(ls) ，shell首先将调用ls ，然后遍历得到的这些返回值。

还有一个冷门的类似特性是 **进程替换（process substitution）** ， <( CMD ) 会执行 CMD 并将结果输出到一个临时文件中，并将 <( CMD ) 替换成临时文件名。这在使用时希望返回值通过文件而不是STDIN传递时很有用。例如， diff <(ls foo) <(ls bar) 会显示文件夹 foo 和 bar 中文件的区别。

说了很多，现在该看例子了，下面这个例子展示了一部分上面提到的特性。这段脚本会遍历我们提供的参数，使用 grep 搜索字符串 foobar，如果没有找到，则将其作为注释追加到文件中。

.. code-block:: bash

  #!/bin/bash

  echo "Starting program at $(date)" # date会被替换成日期和时间

  echo "Running program $0 with $# arguments with pid $$"

  for file in "$@"; do
      grep foobar "$file" > /dev/null 2> /dev/null
      # 如果模式没有找到，则grep退出状态为 1
      # 我们将标准输出流和标准错误流重定向到Null，因为我们并不关心这些信息
      if [[ $? -ne 0 ]]; then
          echo "File $file does not have any foobar, adding one"
          echo "# foobar" >> "$file"
      fi
  done

在条件语句中，比较 `$?` 是否等于0使用了 `-ne` 。Bash实现了许多类似的比较操作，详细信息可以查看 `test manual`_ 手册。 在bash中进行比较时，尽量使用双方括号 [[ ]] 而不是单方括号 [ ]，这样会降低犯错的几率。

当执行脚本时，经常需要提供形式类似的参数。bash可以轻松的实现这一操作，它可以基于文件扩展名展开表达式。这一技术被称为shell的 **通配（globbing）** 。

- 通配符：利用通配符进行匹配时，可以分别使用 ? 和 * 来匹配一个或任意个字符。例如，对于文件foo, foo1, foo2, foo10 和 bar, rm foo?这条命令会删除foo1 和 foo2 ，而rm foo* 则会删除除了bar之外的所有文件。
- 花括号{}：有一系列的指令，其中包含一段公共子串时，可以用花括号来自动展开这些命令。这在批量移动或转换文件时非常方便。

可以参考如下示例：

.. code-block:: bash

  convert image.{png,jpg}
  # 会展开为
  convert image.png image.jpg

  cp /path/to/project/{foo,bar,baz}.sh /newpath
  # 会展开为
  cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

  # 也可以结合通配使用
  mv *{.py,.sh} folder
  # 会移动所有 *.py 和 *.sh 文件

  mkdir foo bar

  # 下面命令会创建foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h这些文件
  touch {foo,bar}/{a..h}
  touch foo/x bar/y
  # 比较文件夹 foo 和 bar 中包含文件的不同
  diff <(ls foo) <(ls bar)
  # 输出
  # < x
  # ---
  # > y

编写 bash 脚本有时候会很别扭和反直觉。例如 `shellcheck`_ 这样的工具可以帮助你定位sh/bash脚本中的错误。

参考文件和扩展阅读
=======================

.. _Advanced Bash-Scripting Guide:

Advanced Bash-Scripting Guide：https://tldp.org/LDP/abs/html/

.. _test manual:

Test manual：https://man7.org/linux/man-pages/man1/test.1.html

.. _shellcheck:

shellcheck：https://github.com/koalaman/shellcheck