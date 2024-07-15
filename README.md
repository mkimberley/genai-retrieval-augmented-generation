# Helm Chart to deploy the frontend and retrieval service (back end) to OpenShift 4.x


This chart deploys part of the application stack for the following GCP Jumpstart application:

https://cloud.google.com/architecture/ai-ml/generative-ai-rag

Whereby the containerised application components run on OCP, with connections to VertexAI and CloudSQL.

How to use:

* Clone this repo into your own environment

* Generate a GCP Service account key, that has access permissions as required to authenticate against CloudSQL and Vertex AI. Save the key as a json file in “files” as “service-account.json”

* Ensure you are authenticated against OCP

* Create a project namespace in which to deploy this chart.


It is probably more convenient for automation purposes to set up local execution environment variables:


```bash
export GOOGLE_PROJECT=google-project
export TEAM_NAME=ocp-project-name
export DB_INSTANCE=genai-rag-db-$(echo $TEAM_NAME)
export SA_EMAIL=$(echo $DB_INSTANCE)@$(echo $GOOGLE_PROJECT).iam.gserviceaccount.com
export SVC_URL="http://rag-$(echo $TEAM_NAME)-genai-retrieval-augmented-generation-retrieval.$(echo $TEAM_NAME).svc.cluster.local"
export DB_REGION=europe-west2
export DB_USER=retrieval-service
export DB_PASSWORD=your-database-password
```

Run:
```bash
oc new-project $(echo $TEAM_NAME)
```

```bash
helm install rag-$(echo $TEAM_NAME) genai-retrieval-augmented-generation/ -f genai-retrieval-augmented-generation/values.yaml --set envFrontend.serviceAccountEmail=$SA_EMAIL \
--set envFrontend.serviceUrl=$SVC_URL --set envRetrieval.dbRegion=$DB_REGION \
--set envRetrieval.dbInstance=$DB_INSTANCE --set dbPassword=$DB_PASSWORD \
--set DB_USER=$DB_USER
```

* Alternatively, create a values.yaml file for your environment.