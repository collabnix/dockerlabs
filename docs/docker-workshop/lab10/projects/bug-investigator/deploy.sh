#!/bin/bash

# =============================================================================
# Deploy Bug Investigator to DigitalOcean
# =============================================================================
# This script automates the deployment of your Bug Investigator agent
# to a DigitalOcean droplet using the cagent 1-Click App.
#
# Prerequisites:
#   - DigitalOcean account with API token
#   - Docker Hub account (for pushing agent)
#   - jq installed (for JSON parsing)
#
# Usage:
#   export DO_TOKEN=your_digitalocean_token
#   export DOCKER_USER=your_dockerhub_username
#   export ANTHROPIC_API_KEY=your_api_key
#   ./deploy.sh
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Bug Investigator - Deployment Script${NC}"
echo "=========================================="

# Check required environment variables
check_env() {
    if [ -z "${!1}" ]; then
        echo -e "${RED}❌ Error: $1 is not set${NC}"
        echo "   export $1=your_value"
        exit 1
    fi
    echo -e "${GREEN}✓${NC} $1 is set"
}

echo -e "\n${YELLOW}Checking prerequisites...${NC}"
check_env "DO_TOKEN"
check_env "DOCKER_USER"
check_env "ANTHROPIC_API_KEY"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}❌ jq is required. Install with: brew install jq${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} jq is installed"

# Check if cagent is installed
if ! command -v cagent &> /dev/null; then
    echo -e "${RED}❌ cagent is required. Install Docker Desktop 4.49+${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} cagent is installed"

# =============================================================================
# Step 1: Push agent to Docker Hub
# =============================================================================
echo -e "\n${YELLOW}Step 1: Pushing agent to Docker Hub...${NC}"

AGENT_IMAGE="docker.io/${DOCKER_USER}/bug-investigator:latest"
cagent push ./cagent.yaml ${AGENT_IMAGE}

echo -e "${GREEN}✓${NC} Agent pushed to ${AGENT_IMAGE}"

# =============================================================================
# Step 2: Create DigitalOcean Droplet
# =============================================================================
echo -e "\n${YELLOW}Step 2: Creating DigitalOcean droplet...${NC}"

DROPLET_NAME="bug-investigator-$(date +%s)"
REGION="sfo3"  # San Francisco
SIZE="s-2vcpu-4gb"  # 2 vCPUs, 4GB RAM

# Create the droplet
RESPONSE=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${DO_TOKEN}" \
  -d "{
    \"name\": \"${DROPLET_NAME}\",
    \"region\": \"${REGION}\",
    \"size\": \"${SIZE}\",
    \"image\": \"cagent\"
  }" \
  "https://api.digitalocean.com/v2/droplets")

# Extract droplet ID
DROPLET_ID=$(echo $RESPONSE | jq -r '.droplet.id')

if [ "$DROPLET_ID" == "null" ] || [ -z "$DROPLET_ID" ]; then
    echo -e "${RED}❌ Failed to create droplet${NC}"
    echo $RESPONSE | jq .
    exit 1
fi

echo -e "${GREEN}✓${NC} Droplet created with ID: ${DROPLET_ID}"

# =============================================================================
# Step 3: Wait for droplet to be ready
# =============================================================================
echo -e "\n${YELLOW}Step 3: Waiting for droplet to be ready...${NC}"

DROPLET_IP=""
for i in {1..30}; do
    DROPLET_INFO=$(curl -s -X GET \
      -H "Authorization: Bearer ${DO_TOKEN}" \
      "https://api.digitalocean.com/v2/droplets/${DROPLET_ID}")
    
    STATUS=$(echo $DROPLET_INFO | jq -r '.droplet.status')
    DROPLET_IP=$(echo $DROPLET_INFO | jq -r '.droplet.networks.v4[0].ip_address')
    
    if [ "$STATUS" == "active" ] && [ "$DROPLET_IP" != "null" ]; then
        break
    fi
    
    echo "   Status: $STATUS... waiting"
    sleep 10
done

if [ -z "$DROPLET_IP" ] || [ "$DROPLET_IP" == "null" ]; then
    echo -e "${RED}❌ Droplet did not become ready in time${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Droplet is ready at IP: ${DROPLET_IP}"

# =============================================================================
# Step 4: Configure droplet
# =============================================================================
echo -e "\n${YELLOW}Step 4: Configuring droplet (waiting for SSH)...${NC}"

# Wait for SSH to be available
for i in {1..12}; do
    if ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 root@${DROPLET_IP} "echo 'SSH ready'" 2>/dev/null; then
        break
    fi
    echo "   Waiting for SSH..."
    sleep 10
done

# Configure API key and pull agent
ssh -o StrictHostKeyChecking=no root@${DROPLET_IP} << EOF
    echo "export ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}" >> ~/.bashrc
    export ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
    
    # Pull the agent
    cagent pull ${AGENT_IMAGE}
    
    echo "Configuration complete!"
EOF

echo -e "${GREEN}✓${NC} Droplet configured"

# =============================================================================
# Summary
# =============================================================================
echo -e "\n${GREEN}=========================================="
echo "🎉 Deployment Complete!"
echo "==========================================${NC}"
echo ""
echo "Droplet Name:  ${DROPLET_NAME}"
echo "Droplet IP:    ${DROPLET_IP}"
echo "Agent Image:   ${AGENT_IMAGE}"
echo ""
echo -e "${YELLOW}To connect and run your agent:${NC}"
echo ""
echo "  ssh root@${DROPLET_IP}"
echo "  cagent run ${AGENT_IMAGE}"
echo ""
echo -e "${YELLOW}To destroy the droplet:${NC}"
echo ""
echo "  curl -X DELETE -H \"Authorization: Bearer \${DO_TOKEN}\" \\"
echo "    \"https://api.digitalocean.com/v2/droplets/${DROPLET_ID}\""
echo ""
