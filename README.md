# cicdtest sample application and Tekton pipeline

This repository contains a minimal Spring Boot application and Kubernetes/OpenShift manifests for a DevSecOps pipeline.  The `src` directory contains the Java code, while `k8s` stores the base and environment overlays and `tekton` defines tasks and pipelines.

## Quick start

1. **Install tools**: Ensure you have `git`, `oc` (OpenShift CLI), `kubectl`, `maven`, `docker`/`podman`, `helm` and `kustomize` installed.
2. **Clone this repository**: `git clone https://gitlab.com/your-namespace/cicdtest.git && cd cicdtest`.
3. **Build locally**: Run `mvn package` in the project root.  The build produces `target/petclinic-0.0.1-SNAPSHOT.jar`.
4. **Container build**: Use `docker build -t petclinic .` or run the provided Tekton pipeline to build and push the image to OpenShift’s internal registry.
5. **Deploy**: Apply the `k8s/overlays/dev` overlay using `kubectl apply -k k8s/overlays/dev`.  This deploys the application to your cluster.

## Structure

```
./src/main/java/com/example/petclinic/Application.java    # Spring Boot application
./pom.xml                                                # Maven build file
./Dockerfile                                             # Container build instructions
./k8s/                                                   # Kubernetes manifests
  ├── base/                                              # Common deployment and service definitions
  │   ├── deployment.yaml
  │   ├── service.yaml
  │   └── kustomization.yaml
  └── overlays/                                          # Per-environment overlays for dev, uat and prod
      ├── dev/
      │   ├── kustomization.yaml
      │   └── image-patch.yaml
      ├── uat/
      │   └── kustomization.yaml
      └── prod/
          └── kustomization.yaml
./tekton/                                                # Tekton tasks, pipeline and triggers
  ├── tasks/
  │   ├── maven-build.yaml
  │   ├── sonarqube-scan.yaml
  │   ├── buildah-build.yaml
  │   └── update-deployment.yaml
  ├── pipeline.yaml
  └── triggers/
      ├── trigger-template.yaml
      └── trigger-binding.yaml
```

You can integrate this repository with GitLab by creating a project, pushing this code and configuring a webhook pointing to your Tekton `EventListener`.  The Tekton pipeline will respond to pushes and automatically build, scan and deploy to dev/uat.  For production releases, follow the merge request approval process described in the workshop documentation.