-- Your SQL goes here
CREATE TABLE IF NOT EXISTS solana_program_builds (
    id VARCHAR NOT NULL,
    repository VARCHAR NOT NULL,
    commit_hash VARCHAR,
    program_id VARCHAR NOT NULL UNIQUE,
    lib_name VARCHAR,
    base_docker_image VARCHAR,
    mount_path VARCHAR,
    cargo_args TEXT[],
    bpf_flag BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (program_id)
);


CREATE TABLE IF NOT EXISTS verified_programs (
    id VARCHAR PRIMARY KEY,
    program_id VARCHAR NOT NULL UNIQUE,
    is_verified BOOLEAN NOT NULL,
    on_chain_hash VARCHAR NOT NULL,
    executable_hash VARCHAR NOT NULL,
    verified_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (program_id) REFERENCES solana_program_builds (program_id)
);

-- Create index on verified_programs.program_id
CREATE INDEX IF NOT EXISTS verified_programs_program_id_idx ON verified_programs (program_id);
CREATE INDEX IF NOT EXISTS solana_program_builds_program_id_idx ON solana_program_builds (program_id);