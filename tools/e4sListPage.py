#!/usr/bin/env python3

"""e4sListPage.py: Generates web pages listing e4s products from e4s_products.yaml"""
__author__ = "Wyatt Spear"

from urllib.request import urlopen
import yaml
import subprocess
import datetime
import html
import sys
import os

timestamp='{:%Y-%m-%d %H:%M:%S}'.format(datetime.datetime.now())

introListBlock='''<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<!--[if lt IE 9]><script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script><![endif]-->
	<title>E4S Packages</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link href="style.css" rel="stylesheet">


<style>
.product_button {
  background-color: #777;
  color: white;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
}

.active, .product_button:hover {
  background-color: #555;
}

</style>
</head>

<body>

<script src="jquery.js"></script>
<script>
$(function () {
    $(".load-html").each(function () {
        $(this).load(this.dataset.source);
    });
});
</script>



<div class="wrapper">

	<header class="header">
		<div class="load-html" id="header" data-source="header.html"></div>
	</header><!-- .header-->

	<div class="middle">

		<div class="container">
			<main class="content">
				<H2>E4S Products</h2>

***TIMESTAMP***<br>
<hr>'''

introCloseBlock='''			</main><!-- .content -->
		</div><!-- .container-->

	</div><!-- .middle-->

</div><!-- .wrapper -->
</body>
</html>'''

introHeadingBlock='''<h2>***HEADING***</h2>
'''

introLinkBlock='''<!-- This is a single product entry. To add more copy and edit from here... -->
<button class="product_button"><b><a href="***LOWNAME***.html">***CAPNAME***</a></b>
</button>
<!-- ...to here (product entry end) -->'''


introBlock='''<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />

	<title>E4S Packages: ***CAPNAME***</title>
  </head>
  <body>
		<h1>***CAPNAME***</h1>

        ***TIMESTAMP***
        <br><br>
'''
spackBlock='''<table>
			<tr>
				<td>Description:</td>
				<td>
                    ***DESCRIPTION***
		        <td>
			</tr>
			<tr>
				<td>Website:</td>
				<td><a href="***SITEADDRESS***">***SITEADDRESS***</a><td>
			</tr>
			<tr>
				<td>Version:</td>
				<td>***SPACKVERSION***<td>
			</tr>
			<tr>
				<td>Spack Hash:</td>
				<td>***SPACKHASH***<td>
			</tr>
		</table>
<hr>'''
endBlock='''
  </body>
</html>	'''

docBlock='''<b>***DOCNAME***</b>
	<br>
<pre>
***DOCTEXT***
</pre>

<a href="***DOCURL***">More...</a>
<hr>
<br>
'''


def getURLHead(url, numChars=200):
    #masteryaml_url="https://raw.githubusercontent.com/UO-OACISS/e4s/master/docker-recipes/ubi7/x86_64/e4s/spack.yaml"
    with urlopen(url) as f:
        head=html.escape(f.read(numChars).decode("utf-8"))
        return head
    #    yamlMap=yaml.safe_load(url)
    #speclist = yamlMap.get('spack').get('specs')

output_prefix=""
if(len(sys.argv)>1):
	if(os.path.isdir(sys.argv[1])):
		output_prefix=sys.argv[1]+"/"
	else:
		print("First argument must be a valid output directory")
		sys.exit(-1)


with open('e4s_products.yaml') as e4slist:
    e4sProducts = yaml.safe_load(e4slist)

with open(output_prefix+'E4S-Products.html', "a") as listPage:
    print(introListBlock.replace("***TIMESTAMP***",timestamp), file=listPage)

    for product in e4sProducts:
        if "heading" in product:
            print(introHeadingBlock.replace("***HEADING***",product['heading']), file=listPage)
            continue

        with open(output_prefix+product['e4s_product'].lower()+".html", "a") as ppage:

            capName=product['e4s_product'].upper()
            lowName=capName.lower()

            print(introLinkBlock.replace("***CAPNAME***",capName).replace("***LOWNAME***", lowName), file=listPage)

            introFix=introBlock.replace("***CAPNAME***",capName).replace("***TIMESTAMP***",timestamp)
            print(introFix, file=ppage)
            rawFileURL = product['repo_url'].replace("blob","raw")
            for doc in product['docs']:
                docHead=getURLHead(rawFileURL+"/"+doc)
                docFix = docBlock.replace("***DOCNAME***",doc).replace("***DOCTEXT***",docHead).replace("***DOCURL***",product['repo_url']+"/"+doc)
                print(docFix, file=ppage)
            #.replace('***DESCRIPTION***',"N/A").replace("***SITEADDRESS***","N/A").replace("***SPACKVERSION***","N/A")

            print(endBlock, file=ppage)
    print(introCloseBlock.replace("***TIMESTAMP***",timestamp), file=listPage)
#subprocess.run(['ls', '-l'], stdout=subprocess.PIPE).stdout.decode('utf-8')

#print('\n'.join(speclist))
