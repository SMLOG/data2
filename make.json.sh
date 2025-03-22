const testFolder = './ttss/';
const fs = require('fs');


let files = fs.readdirSync(testFolder).map(function(v) { 
                  return { name:v,
                           time:fs.statSync(testFolder + v).mtime.getTime()
                         };
               })
               .sort(function(a, b) { return b.time - a.time; })
files=files.filter(e=>e.name.indexOf('.mp3')==e.name.length-4).map(e=> { return {title:e.name,date:e.time,url:'https://smlog.github.io/data2'+testFolder.substring(1)+encodeURIComponent(e.name)}})
files=files.map(e=>{

                if(fs.existsSync( testFolder+e.title.replace('.mp3','.vtt') )){

                e['cc']='https://smlog.github.io/data2/'+testFolder.substring(1)+encodeURIComponent(e.title.replace('.mp3','.vtt'))
                }
                return e;});
console.log(files)
let output = {content:files}
fs.writeFileSync('./ttss.json',JSON.stringify(output,null,2));
