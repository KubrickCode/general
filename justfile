set dotenv-load

root_dir := justfile_directory()

generate-env:
  #!/usr/bin/env bash
  set -euox pipefail

  if [[ ! -f .doppler.env ]]; then
    echo "Error: .doppler.env file not found."
    exit 1
  fi
  source .doppler.env

  if [[ -z "${DOPPLER_TOKEN_ROOT:-}" ]]; then
    echo "Error: DOPPLER_TOKEN_ROOT not set in .doppler.env."
    exit 1
  fi
  if [[ -z "${DOPPLER_TOKEN_VITE:-}" ]]; then
    echo "Error: DOPPLER_TOKEN_VITE not set in .doppler.env."
    exit 1
  fi

  echo "Downloading secrets for dev_root..."
  doppler secrets download --project loa-work --config dev_root --format env --no-file --token "${DOPPLER_TOKEN_ROOT}" | sed 's/"//g' > .env

  echo "Downloading secrets for dev_vite..."
  doppler secrets download --project loa-work --config dev_vite --format env --no-file --token "${DOPPLER_TOKEN_VITE}" | sed 's/"//g' > "{{ frontend_dir }}/.env"

  echo "Environment files generated successfully."

lint target="all":
  #!/usr/bin/env bash
  set -euox pipefail
  case "{{ target }}" in
    all)
      just lint backend
      just lint frontend
      just lint go
      just lint config
      ;;
    backend)
      prettier --write "{{ backend_dir }}/src/**/*.ts"
      cd "{{ backend_dir }}"
      yarn lint
      ;;
    frontend)
      prettier --write "{{ frontend_dir }}/src/**/*.{ts,tsx}"
      cd "{{ frontend_dir }}"
      yarn eslint --ignore-pattern "generated.tsx" --max-warnings=0 "src/**/*.tsx"
      ;;
    go)
      gofmt -w "{{ root_dir }}/src/go"
      ;;
    config)
      prettier --write "**/*.{json,yml,yaml,md}"
      ;;
    *)
      echo "Unknown target: {{ target }}"
      exit 1
      ;;
  esac

# Run pgadmin
# When connecting to DB, the host name must be `host.docker.internal`.
pgadmin:
  #!/usr/bin/env bash
  container=notag_pgadmin
  if docker start $container &> /dev/null; then
    echo "Container $container started."
  else
    echo "Failed to start container $container. Creating a new one..."
    docker run \
      --name $container \
      -e PGADMIN_DEFAULT_EMAIL=admin@example.com \
      -e PGADMIN_DEFAULT_PASSWORD=admin \
      -e PGADMIN_CONFIG_SERVER_MODE=False \
      -e PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED=False \
      -p 8080:80 \
      dpage/pgadmin4
  fi

release version="patch":
    @echo "🚀 Creating {{version}} release..."
    npm version {{version}}
    git push origin main --tags
    git checkout release
    git merge main
    git push origin release
    git checkout main
    @echo "✅ Release complete! Check GitHub Actions."

release-branch-push:
    git push -f origin main:release

test-go:
  go list -f '{{{{.Dir}}' -m | xargs -I {} go test {}/...

test-ts mode="":
  #!/usr/bin/env bash
  cd "{{ ts_dir }}"
  if [ "{{ mode }}" = "watch" ]; then
    yarn test:watch
  elif [ "{{ mode }}" = "coverage" ]; then
    yarn test --coverage
  else
    yarn test
  fi
