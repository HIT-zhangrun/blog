rst文件测试
===========

一级标题
========
二级标题
~~~~~~~~
三级标题
---------
四级标题
^^^^^^^^^
五级标题
""""""""
六级标题
*********

**强调**

*斜体*

``printf()``  

- hhhhhhhh
- hhhhhhhh
- hhhhhhhh
- hhhhhhhh
- hhhhhhhh
- hhhhhhhh

1. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh

a. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh
#. hhhhhhhh


=====  =====  =====
  A      B    A and B
=====  =====  =====
False  False  False
True   False  False
False  True   False
True   True   True
=====  =====  =====

.. note:: This is a note admonition.
 This is the second line of the first paragraph.

 - The note contains all indented body elements
   following.
 - It includes this bullet list.

.. hint:: This is a hint admonition.

.. important:: This is a important admonition.

.. tip:: This is a tip admonition.

.. warning:: This is a warning admonition.

.. caution:: This is a caution admonition.

.. attention:: This is a attention admonition.

.. error:: This is a error admonition.

.. danger:: This is a danger admonition.

.. code-block:: c
   :caption: c test
   :emphasize-lines: 1-5,7
   :linenos:

   #include <stdio.h>

   int main()
   {
      printf("hello, world! This is a C program.\n");
      for(int i=0;i<10;i++ ){
         printf("output i=%d\n",i);
      }

      return 0;
   }