# Create files to be uploaded to devsite. 
# When running locally, run `docfx --serve` in ./yaml/ after this script

mkdir ./etc

npm install
npm run api-extractor
npm run api-documenter

npm i json@9.0.6 -g
NAME=$(cat .repo-metadata.json | json name)

mkdir ./_devsite
cp ./yaml/$NAME/* ./_devsite

# Clean up TOC
# Delete SharePoint item, see https://github.com/microsoft/rushstack/issues/1229
sed -i -e '1,3d' ./yaml/toc.yml
sed -i -e 's/^    //' ./yaml/toc.yml
# Delete interfaces from TOC (name and uid)
sed -i -e '/name: I[A-Z]/{N;d;}' ./yaml/toc.yml
sed -i -e '/^ *\@google-cloud.*:interface/d' ./yaml/toc.yml

sed -i -e '4i\
\ \ \ \ summary: Dialogflow.
' ./yaml/toc.yml

sed -i -e '5i\
\ \ \ \ description: Client library for Dialogflow.
' ./yaml/toc.yml

cp ./yaml/toc.yml ./_devsite/toc.yml
# cp ./quickstart.yml ./_devsite/index.yml
cp ./yaml/$NAME.yml ./_devsite/$NAME.yml
