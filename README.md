Installing Kong Gateway on Red Hat OpenShift Service on AWS (ROSA)
===========================================================

This example stands up a Kong Gateway instance on a pre-provisioned instance of ROSA, using HAProxy as the Ingress Controller instead of Kong Ingress Controller (KIC).  This way, we can leverage OpenShift Routes to proxy requests into Kong Gateway.  Lastly, we enable BasicAuth RBAC for Kong Manager and Developer Portal.

## Prerequisites
1. A Red Hat account so you can access the [Cluster Console](https://console.redhat.com/openshift/).
2. A ROSA instance on AWS.  You can provision ROSA using [these](https://www.rosaworkshop.io/rosa/2-deploy#create-the-cluster) instructions.  I create a `cluster-admin` user with `HTPasswd` as my IdP for demonstration purposes.
3. `oc` CLI
4. `rosa` CLI

## Procedure

1. Copy your enterprise license file to a new file called `license`.

2. Run the install script via a BASH shell, passing the `.apps.*` part or your OpenShift cluster URL e.g. `.apps.simongreen-rosa.27y7.p1.openshiftapps.com`:

```bash
./install.sh <apps URL>
```

3. Login to Kong Manager with `http://manager-kong.<apps URL>` (u: kong_admin p: kong)

4. Kong Dev Portal can be reached at `http://dev-portal.<apps URL>` once Dev Portal has been enabled via the Manager.

5. API requests can be posted to `proxy-kong.<apps URL>`.