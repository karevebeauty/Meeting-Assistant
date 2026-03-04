-- =============================================
-- MEETING ASSISTANT - DATABASE SCHEMA
-- =============================================

-- Users
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Meetings
CREATE TABLE IF NOT EXISTS meetings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  
  -- Meeting metadata
  title VARCHAR(500),
  platform VARCHAR(50), -- 'zoom', 'google_meet', 'teams'
  meeting_url TEXT,
  scheduled_at TIMESTAMPTZ,
  started_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ,
  duration_seconds INTEGER,
  
  -- Recall.ai bot tracking
  recall_bot_id VARCHAR(255) UNIQUE,
  recall_recording_id VARCHAR(255),
  recording_url TEXT,
  
  -- Processing status
  status VARCHAR(50) DEFAULT 'scheduled', 
  -- 'scheduled' | 'bot_joining' | 'recording' | 'processing' | 'completed' | 'failed'
  
  -- AssemblyAI transcription
  assemblyai_transcript_id VARCHAR(255),
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Transcripts
CREATE TABLE IF NOT EXISTS transcripts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  meeting_id UUID REFERENCES meetings(id) ON DELETE CASCADE,
  
  -- Full raw transcript (JSON with speaker labels + timestamps)
  raw_transcript JSONB,
  
  -- Clean readable text
  full_text TEXT,
  
  -- Speakers identified
  speakers JSONB, -- [{id: 'A', name: 'John', talk_time_pct: 45}]
  
  word_count INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Meeting Analysis (AI-generated)
CREATE TABLE IF NOT EXISTS meeting_analysis (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  meeting_id UUID REFERENCES meetings(id) ON DELETE CASCADE,
  
  -- Core outputs
  summary TEXT,              -- 3-5 sentence executive summary
  key_decisions JSONB,       -- [{decision: '...', owner: '...'}]
  action_items JSONB,        -- [{task: '...', owner: '...', due: '...', priority: 'high|medium|low'}]
  topics JSONB,              -- [{topic: '...', duration_pct: 30, sentiment: 'positive'}]
  
  -- Advanced analysis
  meeting_sentiment VARCHAR(20),  -- 'positive', 'neutral', 'negative', 'mixed'
  engagement_score INTEGER,       -- 0-100
  talk_time JSONB,                -- speaker breakdown
  questions_raised JSONB,         -- unanswered questions
  risks_identified JSONB,         -- flagged risks/blockers
  next_meeting_agenda JSONB,      -- suggested agenda items
  
  -- Raw AI output for debugging
  raw_ai_response TEXT,
  model_used VARCHAR(100),
  
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Email delivery log
CREATE TABLE IF NOT EXISTS email_deliveries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  meeting_id UUID REFERENCES meetings(id) ON DELETE CASCADE,
  recipient_email VARCHAR(255),
  sent_at TIMESTAMPTZ,
  status VARCHAR(50),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_meetings_user_id ON meetings(user_id);
CREATE INDEX idx_meetings_status ON meetings(status);
CREATE INDEX idx_meetings_recall_bot_id ON meetings(recall_bot_id);
CREATE INDEX idx_transcripts_meeting_id ON transcripts(meeting_id);
CREATE INDEX idx_analysis_meeting_id ON meeting_analysis(meeting_id);
