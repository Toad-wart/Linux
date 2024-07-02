sudo apt-get update && sudo apt-get -y install lsb-release ca-certificates curl gnupg2
curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-2.x.list
sudo apt-get update
apt list -a opensearch
env OPENSEARCH_INITIAL_ADMIN_PASSWORD=<custom-admin-password> apt-get install opensearch
apt-get install opensearch-dashboards

systemctl enable opensearch
systemctl enable opensearch-dashboards
systemctl start opensearch
systemctl start opensearch-dashboards
