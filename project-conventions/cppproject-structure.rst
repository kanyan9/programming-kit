=============
Cpp项目结构
=============

规范的项目结构便于后期代码维护，经过对github上大量开源C++项目结构进行研究，总结出一个C++项目结构作为项目研发参考。

项目目录结构（project/）
========================

.. code-block:: text

  project（project_name）
  |--deploy
  |--build
  |--doc
  |--example
  |--third_party
  |--include
     |--project_name
  |--src
  |--tools
  |--scripts
  |--platforms
  |--test
  |--LICENSE
  |--CMakeLists.txt
  |--build.sh
  |--toolchain.cmake
  |--.gitignore
  |--.gitmodules
  |--README.rst

其中：

- deploy：用于存放部署、交付的文件，其包含子目录bin、lib、include分别存放本项目最总生成的可
  执行文件、库文件以及对外所提供的头文件；
- build：用于存放构建时cmake产生的中间文件，其包含子目录release和debug；
- doc：用于存放项目的相关文档；
- example：用于存放示例代码；
- third_party：用于存放第三方库，每个第三方库以单独目录的形式组织在third_party目录下。其中
  每个第三方目录下又有include和lib分别存放第三方库的头文件和库文件；
- include/project_name：用于存放每个模块以及整个工程对外的头文件；（具体格式见下文说明）
- src：存放源代码文件，以及内部头文件；（具体格式见下文说明）
- tools：包含一些支持项目构建的工具，如编译器等，一般情况下使用软链接；
- scripts：包含一些脚本文件，如使用Jenkins进行自动化构建时所需要的脚本文件，以及一些用于预处
  理的脚本文件；
- platforms：用于一些交叉编译时所需要的工具链等文件，按照平台进行划分来组织子目录。每个子目录
  下存放toolchain.cmake等用于指定平台的文件；
- test：分模块存放测试代码；
- LICENSE：版权信息说明；
- CMakeLists.txt：cmake文件；
- build.sh：build脚本文件；
- .gitignore：定义git忽略规则；
- .gitmoduls：配置git子模块；
- README.rst：存放project说明文件。

源文件目录结构（src/）
========================

.. code-block:: text

  src
  |--module_1
     |--dir_1
        |--something.h
        |--something.cc
     |--dir_2
     |--module_1.cc
     |--CMakeLists.txt
     |--README.rst
  |--module_2
     |--dir_1
     |--dir_2
        |--something.h
        |--something.cc
     |--module_2.cc
     |--CMakeLists.txt
     |--README.rst
  |--main.cc
  |--CMakeLists.txt

其中：

- 总源码文件目录以project_name命名，即与项目同名，存放在项目根目录下；
- 总源码文件目录以源码文件分模块进行组织，分别以各个模块进行命名存放在 project_name目录下，如
  示例中的module_1、 module_2；
- 在每个子模块目录下，只包含源文件以及该模块内部所调用的头文件；
- 每个子模块的根目录下存放该模块的主要功能逻辑代码，如module_1.cc。另外，可按照功能再划分子目
  录进行源码组织，但不可以出现模块嵌套的情况；
- 若要包含内部头文件时，包含路径要从project_name开始，路径要完整，如#include"
  project_name/module1/dir_1/somthing.h"，以防止头文件名称冲突的情况，同时遵循了 `Google C++ Code Style <https://google.github.io/styleguide/cppguide.html>`_ 。

头文件目录结构（include/）
===========================

.. code-block:: text

  include
  |--project_name
     |--module_1
        |--module_1_header_1.h
        |--module_2_header_2.h
     |--module_2
        |--module_2.h
     |--project_name.h

- 头文件目录（公共）以include/project_name命名，即文件目录为两级，存放在项目根目录下，该目
  录只包含所有对外的头文件；
- 头文件同样分模块进行组织，分别以各个模块进行命名存放在include/project_name目录下，如示例
  中的module_1、module_2；
- include/project_name目录下最多只包含一级子目录，即最多按照模块再划分一级，模块内的功能头
  文件不再以功能进行划分；
- 若要包含外部头文件时，包含路径同样要从project_name开始路径要完整，如#include 
  "project_name/module_2/module_2.h"。

其他
=========

- 针对头文件的包含，顶层CMakeLists.txt只指定${CMAKE_SOURCE_DIR}\include和$
  {CMAKE_SOURCE_DIR}，以保证所有的包含规则都是从工程根目录开始包含；
- 添加include目录使得公共头文件和内部头文件可以分开，使多个模块之间合作开发时项目内部结构更加
  清晰；
