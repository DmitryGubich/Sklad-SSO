FROM ghcr.io/astral-sh/uv:python3.13-alpine

# Install the project into `/src`
WORKDIR /src
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=.
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Install the project's dependencies using the lockfile and settings
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-dev

# Then, add the rest of the project source code and install it
# Installing separately from its dependencies allows optimal layer caching
COPY . /src
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-dev

# Place executables in the environment at the front of the path
RUN mv /src/.venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"