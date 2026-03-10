-- Run this in Supabase Dashboard → SQL Editor

create table if not exists sessions (
  id text primary key,
  expected_count int not null,
  created_at timestamptz default now()
);

create table if not exists responses (
  id uuid primary key default gen_random_uuid(),
  session_id text references sessions(id) on delete cascade,
  participant_name text not null,
  data jsonb not null,
  submitted_at timestamptz default now(),
  unique(session_id, participant_name)
);

-- Enable realtime for live progress updates
alter publication supabase_realtime add table responses;
