### PROJECT STRUCTURE:
The solution to this assessment is based on the following structure: 

[![](https://github.com/hlsd96/cascade/blob/c83b1af0eb5043b864be9515db88ef3351ba409e/graphic_resources/github.png)](https://github.com/hlsd96/cascade/blob/c83b1af0eb5043b864be9515db88ef3351ba409e/graphic_resources/github.png)

- The DBT project is contained in the cascade_proj folder
- Scripts outside the scope of DBT are stored in the root directory
- Screenshots, diagrams, query results and other graphics are stored in the graphic_resources folder.

### 1. DATA EXTRACTION
---

The first step of this asessment is to extract data from `carmen_sightings_20220629061307.xlsx` in order to achieve this, I created `extraction.py` which basically reads the 8 sheets from the Excel files and generates 8 CSV files in the seeds folder: 

[![Python_extraction](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/python.png "Python_extraction")](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/python.png "Python_extraction")

Please note that only a small alteration is made to a few columns as they have special characters and some of them are written in mandarin; for this reason `carmen_sightings_20220629061307.xlsx` also modifies such column names so that DBT does not encounter any issue trying to process those datasets. 

####Snowflake setup
It is also important to set up an environment where all the objects and data are stored, for this I used Snowflake which offers a convenient integration with DBT. You have access to the setup logic in `Snowflake Environment Setup.sql`.
[![](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/setup.png)](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/setup.png)

### 2. COLUMN MAPPING
---
Now that the corresponding CSV files are stored in the seeds folder, it is possible to develop initial models to map and standardize column names that are received from the source. 
Please note that the seed sources are referenced as **sources** and a `sources.yml `file was created for that purpose:

[![sources.yml](https://github.com/hlsd96/cascade/blob/50b89cb6c3d456783ca3964fa11ea05688babfb4/graphic_resources/sources.png)](https://github.com/hlsd96/cascade/blob/50b89cb6c3d456783ca3964fa11ea05688babfb4/graphic_resources/sources.png)

One model was created for each reagion and these modeles can be found in `cascade/cascade_proj/models/src/`
Since no configuration was given to these models, they are created as views by default with the use of CTEs. 


### 3. CREATION OF DATA MODEL
---
The process that was followed to create a model for this scenario is based on the identification of individual entities that represent concepts in the game. The fact that this model needs to be > 1NF is also taken into account.

The following is the data model that was designed for this scenario:

[![data_model](https://github.com/hlsd96/cascade/blob/31de8ff819fd88940c9aa5dd573050a81c107ad1/graphic_resources/ERD.png)](https://github.com/hlsd96/cascade/blob/31de8ff819fd88940c9aa5dd573050a81c107ad1/graphic_resources/ERD.png)

The models that were created to populate the above entities can be found in `cascade/cascade_proj/models/prod/` 

Main considerations: 

- The source does not have unique identifiers for reports or sightings and for this reason IDs were fabricated with the help of `dbt-labs/dbt_utils` (this package is invoked in `packages.yml`)
- T

###Blockquotes

> Blockquotes

Paragraphs and Line Breaks
                    
> "Blockquotes Blockquotes", [Link](http://localhost/)。

###Links

[Links](http://localhost/)

[Links with title](http://localhost/ "link title")

`<link>` : <https://github.com>

[Reference link][id/name] 

[id/name]: http://link-url/

GFM a-tail link @pandao

###Code Blocks (multi-language) & highlighting

####Inline code

`$ npm install marked`

####Code Blocks (Indented style)

Indented 4 spaces, like `<pre>` (Preformatted Text).

    <?php
        echo "Hello world!";
    ?>
    
Code Blocks (Preformatted text):

    | First Header  | Second Header |
    | ------------- | ------------- |
    | Content Cell  | Content Cell  |
    | Content Cell  | Content Cell  |

####Javascript　

```javascript
function test(){
	console.log("Hello world!");
}
 
(function(){
    var box = function(){
        return box.fn.init();
    };

    box.prototype = box.fn = {
        init : function(){
            console.log('box.init()');

			return this;
        },

		add : function(str){
			alert("add", str);

			return this;
		},

		remove : function(str){
			alert("remove", str);

			return this;
		}
    };
    
    box.fn.init.prototype = box.fn;
    
    window.box =box;
})();

var testBox = box();
testBox.add("jQuery").remove("jQuery");
```

####HTML code

```html
<!DOCTYPE html>
<html>
    <head>
        <mate charest="utf-8" />
        <title>Hello world!</title>
    </head>
    <body>
        <h1>Hello world!</h1>
    </body>
</html>
```

###Images

Image:

![](https://pandao.github.io/editor.md/examples/images/4.jpg)

> Follow your heart.

![](https://pandao.github.io/editor.md/examples/images/8.jpg)

> 图为：厦门白城沙滩 Xiamen

图片加链接 (Image + Link)：

[![](https://pandao.github.io/editor.md/examples/images/7.jpg)](https://pandao.github.io/editor.md/examples/images/7.jpg "李健首张专辑《似水流年》封面")

> 图为：李健首张专辑《似水流年》封面
                
----

###Lists

####Unordered list (-)

- Item A
- Item B
- Item C
     
####Unordered list (*)

* Item A
* Item B
* Item C

####Unordered list (plus sign and nested)
                
+ Item A
+ Item B
    + Item B 1
    + Item B 2
    + Item B 3
+ Item C
    * Item C 1
    * Item C 2
    * Item C 3

####Ordered list
                
1. Item A
2. Item B
3. Item C
                
----
                    
###Tables
                    
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell 

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

| Function name | Description                    |
| ------------- | ------------------------------ |
| `help()`      | Display the help window.       |
| `destroy()`   | **Destroy your computer!**     |

| Item      | Value |
| --------- | -----:|
| Computer  | $1600 |
| Phone     |   $12 |
| Pipe      |    $1 |

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |
                
----

####HTML entities

&copy; &  &uml; &trade; &iexcl; &pound;
&amp; &lt; &gt; &yen; &euro; &reg; &plusmn; &para; &sect; &brvbar; &macr; &laquo; &middot; 

X&sup2; Y&sup3; &frac34; &frac14;  &times;  &divide;   &raquo;

18&ordm;C  &quot;  &apos;

##Escaping for Special Characters

\*literal asterisks\*

##Markdown extras

###GFM task list

- [x] GFM task list 1
- [x] GFM task list 2
- [ ] GFM task list 3
    - [ ] GFM task list 3-1
    - [ ] GFM task list 3-2
    - [ ] GFM task list 3-3
- [ ] GFM task list 4
    - [ ] GFM task list 4-1
    - [ ] GFM task list 4-2

###Emoji mixed :smiley:

> Blockquotes :star:

####GFM task lists & Emoji & fontAwesome icon emoji & editormd logo emoji :editormd-logo-5x:

- [x] :smiley: @mentions, :smiley: #refs, [links](), **formatting**, and <del>tags</del> supported :editormd-logo:;
- [x] list syntax required (any unordered or ordered list supported) :editormd-logo-3x:;
- [x] [ ] :smiley: this is a complete item :smiley:;
- [ ] []this is an incomplete item [test link](#) :fa-star: @pandao; 
- [ ] [ ]this is an incomplete item :fa-star: :fa-gear:;
    - [ ] :smiley: this is an incomplete item [test link](#) :fa-star: :fa-gear:;
    - [ ] :smiley: this is  :fa-star: :fa-gear: an incomplete item [test link](#);
            
###TeX(LaTeX)
   
$$E=mc^2$$

Inline $$E=mc^2$$ Inline，Inline $$E=mc^2$$ Inline。

$$\(\sqrt{3x-1}+(1+x)^2\)$$
                    
$$\sin(\alpha)^{\theta}=\sum_{i=0}^{n}(x^i + \cos(f))$$
                
###FlowChart

```flow
st=>start: Login
op=>operation: Login operation
cond=>condition: Successful Yes or No?
e=>end: To admin

st->op->cond
cond(yes)->e
cond(no)->op
```

###Sequence Diagram
                    
```seq
Andrew->China: Says Hello 
Note right of China: China thinks\nabout it 
China-->Andrew: How are you? 
Andrew->>China: I am good thanks!
```

###End