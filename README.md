# tiamat-bitrix

## Docker Environment Setup

This project uses Docker to create a development environment with CentOS 7 for the main application and MySQL 8 for the database.

### Prerequisites

- Docker
- Docker Compose

### Environment Configuration

The Docker environment consists of:

- **App Container**: CentOS 7 based application
- **Database Container**: MySQL 8 

### Getting Started

1. Clone this repository
2. Configure environment variables in `.env` file (already set with default values)
3. Start the Docker containers:

```bash
docker-compose up -d
```

4. Access your application at http://localhost:8080

### Environment Variables

The `.env` file contains the following configuration:

- `MYSQL_DATABASE`: Database name
- `MYSQL_USER`: Database user
- `MYSQL_PASSWORD`: Database password
- `MYSQL_ROOT_PASSWORD`: MySQL root password

### Project Structure

```
.
├── Dockerfile              # Main application Dockerfile (CentOS 7)
├── docker-compose.yml      # Docker Compose configuration
├── .env                    # Environment variables
├── logs/                   # Application logs directory
├── mysql/                  # MySQL configuration
│   └── init/               # Database initialization scripts
└── src/                    # Application source code
```

### Database Initialization

Place any SQL scripts in the `mysql/init/` directory to automatically initialize your database when the container is first created.

### Stopping the Environment

To stop and remove the containers, run:

```bash
docker-compose down
```

Add `-v` flag to also remove volumes:

```bash
docker-compose down -v
```