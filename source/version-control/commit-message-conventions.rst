========================
Commit message书写规范
========================

Commit message的作用
========================
在讲commit message的书写规范前，我们首先来了解commit message的作用。从Git的原理介绍中可知
Git通过保存项目快照，生成一个项目快照树来记录项目的变化，项目的快照在Git中也被称为commit。Commit
的具体作用可参考游戏中的存档，当你通过一个关卡的时候可以存档，下次登录的时候可以从存档处开始接着
玩游戏，不需要从头开始。这里会出现一个问题，究竟应该读取哪个存档作为游戏的开始呢。一般的做法是存档
是保存当前存档的简要信息，根据存档的描述信息进行选择。Commit message就可以看作是commit的信息，
根据commit message用户就可以知道这个commit保存了什么。

为了更快捷清晰的从一个commit message中获取有用的信息，我们就得思考如何规范的书写commit message。
一个规范的commit message可以带给我们：

- 提供更多的项目历史信息，方便快速浏览；
- 可以过滤某些commit（比如文档改动），便于快速查找信息；
- 可以直接根据commit生成Change log文件生成版本升级文档。

书写规范
==========

一般写法
----------
每个commit都对应至少一个issue或pull request。标准的commit message主要由Header、
Body和Footer三部分组成，书写时相互之间用空行隔开。Commit message的任何一行都不能超过100个字
符，这样提交信息在github和各种git工具中都更容易阅读。

.. code-block:: text

  <type>(<scope>): <short summary>
  // 空行
  <body>
  // 空行
  <footer>

Header
*********
Header是查看git log时必需的信息，也是每次commit时必须填写的信息。

.. code-block:: text

  <type>(<scope>): <short summary>

Type
~~~~~~~~
其中典型的type包括：

- feat(feature)：功能特性的变化，比如新增一个功能等

- fix(bug fix)：表示Bug的修复

- docs(documentation)：所有文档内容的增删查改都归于此类

- style(formatting, missing semi colons, ...)：格式修改、标点符号缺失等不影响代码功能的修改

- refactor：对项目结构性调整，可以是多个文件结构的重构

- test(when adding missing tests)：添加test内容

- trans(translation)：翻译英文API docstring或者将中文文档翻译成英文

- build(build file and dependency)：构建系统，影响项目构建的依赖项修改，编译配置文件相关的改动

- ci：在这个项目中专指GitHub Actions中的一些持续集成相关的工作流改动

- chore(maintain)：不在上述类型中的其他修改

Scope
~~~~~~~~
范围（Scope）是可选项，根据修改所影响的内容而定，常见类型有：

- 模块名：data等

- 所属分类：tutorial等

(*)表示多个地方都收到影响。

Summary
~~~~~~~~
总结（Summary）是对commit的简短描述，要求如下：

- 不超过50个字符

- 动词开头，使用第一人称现在时，比如change而不是changes或changed

- 第一个字母小写

- 结尾不加句号

Body
********
当需要对commit进行更加详细的描述时，通常会将其放在正文部分。

更常见的情况是，在issue/pull request中进行具体的讨论和更改，仅在有必要的情况下，会选择在commit message中说明原因和影响。

Footer
********
用于添加各种参考信息，比如issues/pull request的ID，或参考的网页链接等等。

精简写法
---------
当commit message中不包含Body部分时，可进行精简表示:

.. code-block:: text

  docs(readme): modify the description of xxx  (#222)

其中#后跟着的数字是对应的issue/pull request ID.

参考文件及扩展阅读
===================
AngularJS commit conventions: https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/edit?pli=1

Megengine commit conventions: https://www.megengine.org.cn/doc/stable/zh/development/docs/commit-message.html