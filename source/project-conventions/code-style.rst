===========
代码规范
===========

概述
===========
在编码阶段，程序员的核心任务就是写出在预处理、编译和运行等不同阶段执行的代码，有句经典的编程格言：

**“任何人都能写出机器能看懂的代码，但只有优秀的程序员才能写出人能看懂的代码”**

所以编码阶段最重要的目标不是实现复杂的代码逻辑，而是写出清晰易懂的代码，也就是要有好的代码规范。同时现代复杂项目的代码通常是由一个团队共同完成的，提升项目代码质量的首要前提是统一的代码规范。统一优秀的代码规范对程序开发至关重要。

代码规范包括变量命名规范、代码格式和其他一些限制，变量规范有驼峰标识比如“大驼峰”（UpperCamelCase）和“小驼峰”（lowerCamelCase）等，代码格式包括统一缩紧、空格位置、花括号、80列限制等，其他限制包括不能使用某些特定的语法等。在Github等网站可以找到一些开源的代码规范，比较著名的代码规范包括 `Google Code Style <https://google.github.io/styleguide/cppguide.html>`_ 等。

在编码和团队协作过程中优先制定一份代码规范，并严格遵守提升代码质量。

代码规范工具
=============
在实际编码和团队协作过程中也可以使用一些代码格式工具，帮助程序员实现代码风格的统一，提升开发效率。以C/C++语言为例，比较常用的工具包括cpplint、clang-format和EditorConfig等。

Cpplint
-----------------
Cpplint是一款命令行工具，用于根据Google的C/C++代码规范检查C/C++文件的代码风格问题。Cpplint曾经由Google公司开发和维护，如今Google不再维护cpplint的公开版本，如果想使用公开维护的最新版本cpplint请参考 `Cpplint分支版本 <https://github.com/cpplint/cpplint>`_ 。

Clang-format
-----------------
Clang-format是LLVM开发的用于格式化C/C++/Java等多种语言代码的工具，借助clang-format可以实现项目代码风格统一。

安装
*******
Clang-format在使用前需要安装，在Ubuntu系统上安装命令如下：

.. code-block:: bash

  $ sudo apt install clang-format-15

Clang-format有多个版本可供选择，这里选择15。不同版本所支持的格式化选项不同，但是向后兼容。除Ubuntu系统外的其他Linux发行版可使用其对应的包管理工具安装。

使用
*******

命令行使用
~~~~~~~~~~~~
完成安装后，可以在终端中使用 `clang-format` 命令来对代码文件进行格式化，具体如下：

.. code-block:: bash

  $ clang-format -style=google -i demo.cc

以上的命令表示使用Google Code Style对 demo.cc 文件进行格式化。

编辑器使用
~~~~~~~~~~~~
编辑器可以通过插件的方式使用clang-format，以当前最流行的编辑器Vscode为例，介绍clang-format的使用。

在Vscode中使用clang-format时首先要安装 `Clang-format插件 <https://marketplace.visualstudio.com/items?itemName=xaver.clang-format>`_ ，安装完成后进行设置，指定编辑器默认使用formatter，同时开启设置中的 autoSave 和 formatOnSave 选项，实现代码修改后的自动格式化保存，设置参考如下：

.. code-block:: json 

  {
    "files.autoSave": "afterDelay",
    "editor.formatOnSave": true,
    "[cpp]": {
      "editor.defaultFormatter": "xaver.clang-format"
    }
  }

配置完成后每次修改完代码保存时，vscode的clang-format插件就会调用系统中的clang-format（默认从 `PATH` 环境变量中查找，也可以单独指定路径）对代码进行格式化。

自定义
**********
有时程序员并不想使用clang-format内置的代码风格，而是要使用自己团队的代码风格格式化代码。这时就需要对clang-format的代码风格进行自定义。Clang-format提供代码风格自定义功能，程序员可以在已有代码风格的基础上自定义一个名为 `.clang-format` 的代码风格文件，并放置在项目根目录下，以后保存代码时clang-format将根据文件中定义的风格对代码进行格式化。

自定义代码风格时首先根据已有代码风格生成 `.clang-format` 模板文件，如下：

.. code-block:: bash

  $ clang-format -style=google -dump-config > .clang-format

然后根据团队开发规范对生成的 `.clang-format` 文件进行自定义，自定义时文件中各选项代表的含义可参考 `Clang-Format Style Options <https://clang.llvm.org/docs/ClangFormatStyleOptions.html>`_ 。

在编写代码时如果希望某个代码段不要参与格式化，可以使用 `// clang-format off` 和 `// clang-format on` 注释对该代码片段进行修饰。

EditorConfig
-----------------
EditorConfig也是常用的保持项目代码一致性的工具。无论使用哪种编辑器或IDE，在项目中设置.editorconfig自定义文件就可以控制代码缩进样式、制表符宽度和行尾字符等编码样式。该文件用来定义项目的编码规范，编辑器的行为会与.editorconfig文件中定义的一致，并且其优先级比编辑器自身的设置要高，这在多人参与开发项目时保持项目代码风格一致十分重要。

以Vscode中使用EditorConfig为例，主要分为以下几步。

.editorconfig文件
********************
在当前项目根目录下添加.editorconfig文件，该文件是定义一些格式化规则，这些规则并不会直接被Vscode解析。

EditorConfig官网给出一个.editorconfig文件示例，它为Python和JavaScript文件设置了行尾和缩进样式。

.. code-block:: text

  # EditorConfig is awesome: https://EditorConfig.org

  # top-most EditorConfig file
  root = true

  # Unix-style newlines with a newline ending every file
  [*]
  end_of_line = lf
  insert_final_newline = true

  # Matches multiple files with brace expansion notation
  # Set default charset
  [*.{js,py}]
  charset = utf-8

  # 4 space indentation
  [*.py]
  indent_style = space
  indent_size = 4

  # Tab indentation (no size specified)
  [Makefile]
  indent_style = tab

  # Indentation override for all JS under lib directory
  [lib/**.js]
  indent_style = space
  indent_size = 2

  # Matches the exact files either package.json or .travis.yml
  [{package.json,.travis.yml}]
  indent_style = space
  indent_size = 2

语法
~~~~~~~~~~
EditorConfig配置文件需要是UTF-8编码的，以回车换行或换行作为一行的分隔符。斜线（/）被用作一个路径分隔符，井号（#）被用作注释，注释需要与注释符号写在同一行。

通配符
~~~~~~~~~~

- *               匹配除/之外的任意字符串
- **              匹配任意字符串
- ?               匹配任意单个字符 
- [name]          匹配name中的任意一个单一字符
- [!name]         匹配不存在name中的任意一个单一字符
- {s1,s2,s3}      匹配给定的字符串中的任意一个（用逗号分隔）
- {num1..num2}    匹配num1到num2之间的任意一个整数，这里的num1和num2可以为正整数也可以为负整数。

核心属性
~~~~~~~~~~
EditorConfig主要包括如下核心属性，所有属性和属性值都是忽略大小写的，解析时都看成小写。

- indent_style：设置缩进分隔包括tab（硬缩进）、space（软缩进）
- indent_size：设置缩进列数，如果indent_style设置为tab，则默认为tab_width
- tab_width：设置tab缩进列数，默认是indent_size
- end_of_line：设置换行符，值为lf、cr和crlf
- charset：设置编码
- trim_trailing_whitespace
- insert_final_newline
- root

控制指定文件类型的缩进
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: text 

  [{*.json,*.yml}]
  indent_style = space
  indent_size = 2

以上配置约束.json，.yml文件使用空格替代tab，并且一个tab会被替换为2个空格。

文件末尾新行
~~~~~~~~~~~~~~~

.. code-block:: text

  [*]
  end_of_line = lf
  insert_final_newline = true

以上配置约束所有文件格式，每一行的尾部自动调整为lf，且文件的末尾是一个空行。

文件层级结构和优先级
~~~~~~~~~~~~~~~~~~~~
如果将.editorconfig文件添加到文件层次结构中的某个文件夹，则其设置将应用于该文件夹及其下所有的适用文件，所以最近的配置文件中配置项优先级更高。当要包含其他地方的代码而不想更改其风格约定时，这样机制将发挥重要的作用。

EditorConfig插件
*******************
在vscode里面安装EditorConfig插件，Vscode并不是原生支持EditorConfig，该插件的作用是读取第一步创建的editorconfig文件中定义的规则，并覆盖user/workspace settings中的对应配置。

正常使用EditorConfig之前还要安装editorconfig依赖包，主要是因为EditorConfig依赖于editorconfig包，不安装的可能会导致EditorConfig无法正常解析定义的.editorconfig文件。安装依赖包命令如下：

.. code-block:: bash

  $ npm install -g editorconfig | npm install -D editorconfig

完成EditorConfig插件和依赖包安装后即可正常使用，使用时打开需要格式化的文件并手动格式化代码，快捷键为 `shift + alt + f` 。

参考文件和扩展阅读
====================

OpenResty C Code Style：https://openresty.org/cn/c-coding-style-guide.html

Clang Format：https://clang.llvm.org/docs/ClangFormat.html

EditorConfig：https://editorconfig.org/

EditorConfig github：https://github.com/editorconfig