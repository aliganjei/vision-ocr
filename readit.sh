#!/bin/bash

FILENAME=$1 # expected to be a PDF file
BUCKET='gs://pdfs2ocr/'

BASENAME=$(basename -- $FILENAME) # removing the .pdf suffix. assuming there is no dot in the filename
BASENOEXT="${BASENAME%.*}"
gsutil cp $FILENAME $BUCKET

REQ_URI=${BUCKET}${BASENAME}
DEST_URI=${BUCKET}${BASENOEXT}/

REQUEST="
{
  \"requests\":[
    {
      \"inputConfig\": {
        \"gcsSource\": {
          \"uri\": \"$REQ_URI\"
        },
        \"mimeType\": \"application/pdf\"
      },
      \"features\": [
        {
          \"type\": \"DOCUMENT_TEXT_DETECTION\"
        }
      ],
      \"outputConfig\": {
        \"gcsDestination\": {
          \"uri\": \"$DEST_URI\"
        },
        \"batchSize\": 1
      }
    }
  ]
}
"

curl -X POST -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) -H "Content-Type: application/json; charset=utf-8" -d "$REQUEST" https://vision.googleapis.com/v1/files:asyncBatchAnnotate