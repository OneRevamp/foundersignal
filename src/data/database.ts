import Dexie, { type EntityTable } from 'dexie';

export interface Reflection {
  id?: number;
  createdAt: Date;
  matterToday: string;
  avoidedDecision: string;
  additionalNotes: string;
}

export interface AttentionLog {
  id?: number;
  startedAt: Date;
  endedAt?: Date;
  category: string;
  durationMinutes: number;
  source: 'manual' | 'browser';
}

export interface DeepWorkSession {
  id?: number;
  startedAt: Date;
  endedAt?: Date;
  objective: string;
  plannedMinutes: number;
  completedMinutes: number;
}

export interface Signal {
  id?: number;
  contentId: string;
  title: string;
  body: string;
  category?: string;
  actionItem?: string;
  publishedAt: Date;
  cachedAt: Date;
}

export interface Lesson {
  id?: number;
  contentId: string;
  title: string;
  body: string;
  category?: string;
  publishedAt: Date;
  cachedAt: Date;
  completedAt?: Date;
}

export interface WeeklyReview {
  id?: number;
  weekStarting: Date;
  narrative: string;
  generatedAt: Date;
}

class FounderSignalDatabase extends Dexie {
  reflections!: EntityTable<Reflection, 'id'>;
  attentionLogs!: EntityTable<AttentionLog, 'id'>;
  deepWorkSessions!: EntityTable<DeepWorkSession, 'id'>;
  signals!: EntityTable<Signal, 'id'>;
  lessons!: EntityTable<Lesson, 'id'>;
  weeklyReviews!: EntityTable<WeeklyReview, 'id'>;

  constructor() {
    super('founder-signal');
    this.version(1).stores({
      reflections: '++id, createdAt',
      attentionLogs: '++id, startedAt, category',
      deepWorkSessions: '++id, startedAt',
      signals: '++id, &contentId, publishedAt',
      lessons: '++id, &contentId, publishedAt, completedAt',
      weeklyReviews: '++id, weekStarting',
    });
  }
}

export const localDatabase = new FounderSignalDatabase();
