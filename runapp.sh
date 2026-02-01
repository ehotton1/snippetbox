echo "Enter settings"
read -s -p "Enter HTTPS port:" SNIPPETBOX_HTTPS_PORT
echo ""
read -s -p "Enter DB name:" SNIPPETBOX_DB_NAME
echo ""
read -s -p "Enter DB user:" SNIPPETBOX_DB_USER
echo ""
read -s -p "Enter DB password:" SNIPPETBOX_DB_PASSWORD
echo ""
echo "Running app"
go run ./cmd/web -addr=":$SNIPPETBOX_HTTPS_PORT" -dsn="$SNIPPETBOX_DB_USER:$SNIPPETBOX_DB_PASSWORD@/$SNIPPETBOX_DB_NAME?parseTime=true"