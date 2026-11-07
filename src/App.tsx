import { useEffect, useState } from 'react';
import { localDatabase } from './data/database';

type Section = 'Today' | 'Reflection' | 'Attention' | 'Deep Work' | 'Library' | 'Review' | 'Journey' | 'Settings';

const sections: { label: Section; mark: string }[] = [
  { label: 'Today', mark: '◷' },
  { label: 'Reflection', mark: '✳' },
  { label: 'Attention', mark: '◉' },
  { label: 'Deep Work', mark: '↗' },
  { label: 'Library', mark: '▤' },
  { label: 'Review', mark: '⌁' },
  { label: 'Journey', mark: '⌖' },
];

export default function App() {
  const [active, setActive] = useState<Section>('Today');
  const [storageReady, setStorageReady] = useState(false);

  useEffect(() => {
    let mounted = true;
    void localDatabase.open()
      .then(() => { if (mounted) setStorageReady(true); })
      .catch(() => { if (mounted) setStorageReady(false); });
    return () => { mounted = false; };
  }, []);

  return (
    <div className="app-frame">
      <aside className="sidebar">
        <a className="brand" href="#today" onClick={() => setActive('Today')} aria-label="Founder Signal home">
          <span className="brand-mark">F<span>.</span></span>
          <span className="brand-name">founder signal</span>
        </a>
        <div className="nav-caption">YOUR SPACE</div>
        <nav aria-label="Main navigation">
          {sections.map((section) => (
            <button key={section.label} className={`nav-item ${active === section.label ? 'active' : ''}`} onClick={() => setActive(section.label)}>
              <span className="nav-mark" aria-hidden="true">{section.mark}</span>
              {section.label}
            </button>
          ))}
        </nav>
        <div className="sidebar-bottom">
          <button className={`nav-item ${active === 'Settings' ? 'active' : ''}`} onClick={() => setActive('Settings')}>
            <span className="nav-mark" aria-hidden="true">⚙</span>Settings
          </button>
          <p className="privacy-note"><span className="privacy-dot" /> Your data stays on this device.</p>
        </div>
      </aside>

      <main className="main-content">
        <header className="topbar">
          <span className="eyebrow">A LITTLE SPACE TO THINK</span>
          <div className="topbar-right"><span className="local-status"><span className="status-dot" /> {storageReady ? 'Stored on this device' : 'Preparing local storage'}</span></div>
        </header>
        <section className="page-content">
          <div className="date-line">YOUR SPACE · {new Intl.DateTimeFormat('en', { weekday: 'long', month: 'long', day: 'numeric' }).format(new Date()).toUpperCase()}</div>
          <h1>{active === 'Today' ? <>Make room for<br /><em>what matters.</em></> : active}</h1>
          <p className="intro">A calmer way to protect your attention, think clearly, and do meaningful work.</p>

          {active === 'Today' ? (
            <div className="today-grid">
              <article className="signal-card">
                <div className="card-kicker">YOUR DAILY SIGNAL <span>01 / 08</span></div>
                <div className="signal-placeholder"><span className="signal-symbol">✳</span><p>Your next useful thought<br />starts here.</p></div>
                <div className="card-foot"><span>DAILY READING · 2–5 MIN</span><span>COMING IN PHASE 1 ↗</span></div>
              </article>
              <div className="side-column">
                <article className="quiet-card"><span className="card-kicker">A MOMENT TO REFLECT</span><h2>What deserves<br />your attention today?</h2><p>Make a little space to notice before you move.</p><button className="text-link" onClick={() => setActive('Reflection')}>Open reflection <span>↗</span></button></article>
                <article className="quiet-card small-card"><span className="card-kicker">YOUR PRACTICE</span><h2>Work with intention.</h2><button className="text-link" onClick={() => setActive('Deep Work')}>Explore deep work <span>↗</span></button></article>
              </div>
            </div>
          ) : (
            <div className="empty-state"><span className="empty-mark">✳</span><h2>{active} will take shape in its phase.</h2><p>We’re building Founder Signal one thoughtful piece at a time.</p><button className="text-link" onClick={() => setActive('Today')}>Back to today <span>↗</span></button></div>
          )}
          <footer className="page-footer"><span>PROTECT ATTENTION. IMPROVE JUDGMENT.</span><span>FOUNDER SIGNAL · {new Date().getFullYear()}</span></footer>
        </section>
      </main>
    </div>
  );
}
