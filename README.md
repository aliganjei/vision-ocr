# vision-ocr

For those who want to OCR their PDF documents using GCP's Vision API, this repo offers some tools to help.

Please follow this guide to set up your GCP project, enable the API and set up your local environment.
https://cloud.google.com/vision/docs/before-you-begin

To use this script, you need to have gcloud installed and GOOGLE_APPLICATION_CREDENTIALS set to point to valid credentials. 

a sample workflow would look like this:

1- Create a bucket. hardcode its name in readit.sh 
2- run readit.sh against your pdf file:
$ ./readit.sh /path/to/mytext.pdf

3- on success, output would show an operation id:

{
  "name": "projects/some-project-name/operations/5812ad89e46f2c02"
}

4- wait for the operation to complete. if you want, can check the status using this command:

curl -X GET -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" -H "Content-Type: application/json" https://vision.googleapis.com/v1/operations/5812ad89e46f2c02

5- Once done, it will create a new folder on your bucket containing a json file per page. download them to a local directory and feed the path to get-vision-json-text.py:

python3 get-vision-json-text.py /path/to/mytext-output/ > my-text-outeput.txt
