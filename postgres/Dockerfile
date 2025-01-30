FROM postgres:15-alpine

# Copy custom PostgreSQL configuration if needed
# COPY postgresql.conf /etc/postgresql/postgresql.conf

# Add any initialization scripts
COPY init.sql /docker-entrypoint-initdb.d/

# Set environment variables
ENV POSTGRES_DB=playfair
ENV POSTGRES_USER=playfair
ENV POSTGRES_PASSWORD=playfair