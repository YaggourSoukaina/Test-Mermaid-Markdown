#!/usr/bin/env bash
# Usage: demo-md-mermaid.sh document.md
#
# This can be invoked on any Markdown file to render embedded mermaid diagrams, provided they are presented in the following format:
#
# ![rendered image description](relative/path/to/demo_rendered_image.png)
# <details>
#  <summary>diagram source</summary>
#  This details block is collapsed by default when viewed in GitHub. This hides the mermaid graph definition, while the rendered image
# linked above is shown. The details tag has to follow the image tag. (newlines allowed)'
#
# ```mermaid
# Graph LR 
#    A[Christmas] -->|Get money| B(Go shopping) 
#    B --> C{Let me think} 
#    C -->|One| D[Laptop] 
#    C -->|Two| E[iPhone] 
#    C -->|Three| F[fa:fa-car Car]
# ```
# </details>
#
# Das Skript holt die Diagrammdefinition aus dem Meerjungfrau-Codeblock und rendert sie in die Bilddatei und den Pfad, die im angegeben sind
# Image-Tag mit mermaid-cli. Das gerenderte Bild kann im SVG- oder PNG-Format vorliegen, was auch immer angegeben wird, wird generiert.

set -eu
if [ " $1 "  ==  " " ] ;  dann
  echo  " $( tput setaf 1 ) Kein Markdown-Dokument angegeben $( tput sgr0 ) "
  Echo  " "
  Katze $0  | grep -E " ^# "  | grep -Ev " ^#!/ "  | sed -E ' s/^#[ ]?// '
  Ausgang 1
fi
markdown_input= $1
image_re= " .*\.(svg|png)$ "
echo  " Markdown-Datei: $markdown_input "

rm -f .demo-md-mermaid-config.json .demo-md-mermaid.css
mermaid_config= ' {"flowchart": {"useMaxWidth": false }} '
mermaid_css= ' #container > svg { max-width: 100% !important; } '
echo  " $mermaid_config "  >> .render-md-mermaid-config.json
echo  " $mermaid_css "  >> .render-md-mermaid.css

mermaid_file= " "
IFS= $' \n '
for  line  in  $( perl -0777 -ne ' while(m/!\[.*?\]\(([^\)]+)\)\n+<Details>([\s\S]*?) ```Meerjungfrau\n([\s\S]*?)\n```/g){print "$1\n$3\n";} '  " $markdown_input " )
tun
    if [[ $line  =~  $image_re ]] ;  dann
        mermaid_file= " $line .mermaid "
        wenn [[ !  " $mermaid_file "  =~ ^. * /. * ]] ;  dann
            mermaid_file= " ./ $mermaid_file "
        fi
        mkdir -p -- " ${mermaid_file %/* } "
    anders
        wenn [[ !  " $mermaid_file "  =  " " ]] ;  dann
            echo  " $line "  >>  " $mermaid_file "
        fi
    fi
fertig ;
for  mermaid_img  in  $( find . -name " *.mermaid "  | sed -E ' s/((.*).mermaid)/\2|\1/ ' )
tun
    image_file= ${mermaid_img % | * }
    mermaid_file= ${mermaid_img #* |}
    if [[ " $2 "  ==  " im Container " ]] ;  dann
        /home/mermaidcli/node_modules/.bin/mmdc -p /puppeteer-config.json -o " $image_file " -i " $mermaid_file " -t neutral -C " .demo-md-mermaid.css " -c " . demo-md-mermaid-config.json " -s 4
    anders
        docker run --rm -t -v " $PWD :/data " minlag/mermaid-cli:latest -o " /data/ $image_file " -i " /data/ $mermaid_file " -t neutral -C " /data/ .demo-md-mermaid.css " -c " /data/.demo-md-mermaid-config.json " -s 4
    fi
    if [[ " $image_file "  =~ ^. * \. svg$]] ;  dann
        sed -i.bak -e ' s/<br>/<br\/>/g '  $image_file
    fi
    echo  " Erzeugt: $image_file "
    rm -f " $mermaid_file "  " $image_file .bak "
getan
rm -f .demo-md-mermaid-config.json .demo-md-mermaid.css
