# Meeting Assistant — Frontend Design Document

**Date:** 2026-03-03
**Approach:** "The Command Center" — Bold, dark-accented, data-dense, enterprise-grade
**Stack:** Next.js + Tailwind CSS + Framer Motion
**Audience:** SaaS product for enterprise customers

---

## 1. Design System

### Typography
- **Headings:** Inter (geometric, modern, tight tracking)
- **Body:** Inter (clean, legible at small sizes)
- **Mono:** JetBrains Mono (transcripts, timestamps, data)
- **Scale:** 12 / 14 / 16 / 20 / 24 / 32 / 48 / 64 / 80px

### Color Tokens

| Token | Hex | Usage |
|---|---|---|
| `bg-primary` | `#0A0A0F` | App background, hero |
| `bg-surface` | `#12121A` | Cards, panels, sidebar |
| `bg-elevated` | `#1A1A28` | Hover states, active items |
| `border-subtle` | `#2A2A3D` | Borders, dividers |
| `text-primary` | `#F0F0F5` | Headings, primary content |
| `text-secondary` | `#8888A0` | Labels, supporting text |
| `text-muted` | `#555570` | Disabled, placeholder |
| `accent-violet` | `#7C5CFC` | Primary CTA, active states, links |
| `accent-violet-hover` | `#6B4AEB` | Hover on violet elements |
| `accent-cyan` | `#00D4FF` | Highlights, secondary accent |
| `positive` | `#34D399` | Success, positive sentiment |
| `negative` | `#F87171` | Error, negative sentiment, high priority |
| `warning` | `#FBBF24` | Medium priority, caution |
| `neutral` | `#94A3B8` | Neutral sentiment |

### Spacing
4px base grid: 1(4) 2(8) 3(12) 4(16) 6(24) 8(32) 12(48) 16(64) 24(96) 32(128)

### Border Radius
- Small (badges, tags): 6px
- Medium (cards, inputs): 12px
- Large (modals, panels): 16px
- Full (pills, avatars): 9999px

### Shadows
- `shadow-card`: `0 1px 3px rgba(0,0,0,0.3), 0 1px 2px rgba(0,0,0,0.2)`
- `shadow-elevated`: `0 8px 32px rgba(0,0,0,0.4)`
- `shadow-glow-violet`: `0 0 24px rgba(124,92,252,0.3)`
- `shadow-glow-cyan`: `0 0 24px rgba(0,212,255,0.2)`

### Motion Rules
- **Scroll reveals:** fade-up, 0.6s ease-out, stagger 0.1s per element
- **Hover states:** 0.2s ease on cards, buttons, links
- **Page transitions:** 0.3s crossfade
- **Micro-interactions:** 0.15s ease for toggles, checkboxes, badges
- **All motion:** gated by `prefers-reduced-motion: reduce`

---

## 2. Page Designs

### 2.1 Marketing / Landing Page

**Purpose:** Convert visitors into sign-ups. Communicate value in under 10 seconds.

**Story flow (scroll sequence):**

#### Hero Section
- Full-bleed dark background (`#0A0A0F`)
- Large headline (64-80px): **"Every meeting. Every action item. Handled."**
- Subheadline (20px, `text-secondary`): "AI joins your meetings, records every word, and delivers structured notes with action items, decisions, and risks — before you finish your coffee."
- Two CTAs: **"Start Free Trial"** (violet, solid) + **"Watch Demo"** (ghost/outline, cyan border)
- Hero visual: animated product screenshot showing a meeting being processed in real-time (the pipeline: Recording → Transcribing → Analyzing → Done). Subtle glow behind the product frame.
- Platform badges below CTAs: "Works with Zoom, Google Meet, Microsoft Teams"

#### Social Proof Bar
- Horizontal strip with logos of recognizable companies (placeholder for now)
- Stat counters (animate on scroll): "10,000+ meetings processed" / "50,000+ action items captured" / "98% accuracy"

#### Feature Sections (3 full-width blocks, alternating layout)

**Block 1: "Your AI meeting teammate"**
- Left: Large product screenshot of the dashboard showing action items view
- Right: Feature bullets with icons
  - Bot joins in one click — paste your meeting link
  - Records, transcribes, identifies every speaker
  - Works silently in the background

**Block 2: "From chaos to clarity in minutes"**
- Right: Product screenshot of a meeting detail view (summary, decisions, risks)
- Left: Feature bullets
  - Executive summary in 3 sentences
  - Action items with owners and deadlines
  - Key decisions, risks, and unresolved questions

**Block 3: "Built for teams that move fast"**
- Full-width: Analytics dashboard screenshot showing engagement scores, talk-time breakdowns, meeting trends
- Overlay text: "Track meeting effectiveness across your entire organization"

#### How It Works (3-step)
- Horizontal 3-card layout on dark surface
- Step 1: "Paste your meeting link" (icon: link/chain)
- Step 2: "Our AI joins and listens" (icon: bot/headphones)
- Step 3: "Get notes in your inbox" (icon: email/check)
- Each card has a subtle violet glow on hover

#### Pricing Section
See Section 2.4 below.

#### Final CTA Section
- Dark gradient with violet glow
- "Stop losing track of what matters."
- Large "Start Your Free Trial" button
- "No credit card required. 5 free meetings."

#### Footer
- 4-column grid: Product, Company, Resources, Legal
- Social links, copyright

---

### 2.2 Dashboard (App — Post-Login)

**Layout:** Fixed sidebar (240px) + main content area

#### Sidebar Navigation
- Dark surface (`#12121A`)
- Logo at top
- Nav items (icon + label):
  - **Action Items** (default/home view) — checkmark icon
  - **Meetings** — calendar icon
  - **Analytics** — chart icon
  - **Settings** — gear icon
- Active state: violet left border + `bg-elevated` background
- Bottom of sidebar: user avatar, name, plan badge ("Enterprise"), logout
- "Join Meeting" button (violet, prominent) pinned above the nav items

#### Action Items View (Default Home)

**Top bar:**
- Page title: "Action Items"
- Filter pills: "All" / "Mine" / "High Priority" / "Overdue" — pill-style toggle, violet active state
- Search input (ghost style, icon left)

**Main content:**
- Grouped by due date: "Overdue", "Today", "This Week", "Later", "No Date"
- Each group header: bold label + count badge
- Each action item row:
  - Checkbox (circular, violet fill on complete)
  - Task text (primary)
  - Owner avatar + name (small, secondary)
  - Source meeting title (small, cyan link to meeting detail)
  - Priority badge (colored pill: red/amber/green)
  - Due date (text-secondary, red if overdue)
- Completed items: strike-through, muted text, collapsed by default
- Empty state: illustration + "No action items yet. Join a meeting to get started."

#### Meetings View

**Top bar:**
- Page title: "Meetings"
- Filter: "All" / "Completed" / "In Progress" / "Failed"
- Search
- "Join Meeting" button (violet)

**Meeting list:**
- Card-based vertical list (full-width cards)
- Each card:
  - Left: Platform icon (Zoom blue dot, Meet green dot, Teams purple dot)
  - Title (bold), date + duration (secondary)
  - Status badge: "Completed" (green), "Recording" (blue, pulsing dot), "Processing" (amber, spinner), "Failed" (red)
  - Summary snippet (2 lines, truncated)
  - Stats row: "5 action items" / "3 decisions" / "82% engagement" / sentiment badge
- Click → opens Meeting Detail page

#### Meeting Detail Page

**Header:**
- Back arrow + meeting title
- Platform badge, date, duration, sentiment badge, engagement score
- Action buttons: "Share Notes" / "Export PDF" / "Email Summary"

**Tab navigation:** Summary | Action Items | Transcript | Analytics

**Summary tab:**
- Executive summary card (elevated surface, generous padding)
- Key Decisions section — each decision as a card with owner tag
- Topics Discussed — horizontal pill/tag layout with sentiment color coding and % time
- Risks & Blockers — red-tinted cards with severity badges
- Unresolved Questions — amber-tinted list
- Next Meeting Suggestions — agenda bullet list

**Action Items tab:**
- Same component as the global action items view, but filtered to this meeting
- Can check off items, change priority inline

**Transcript tab:**
- Monospace text, speaker labels color-coded
- Timestamps on left gutter
- Chapters/topics as collapsible sections with headers
- Search within transcript
- Click timestamp → jump to that point

**Analytics tab:**
- Speaker talk-time: horizontal bar chart, one bar per speaker, colored
- Engagement score: large circular gauge (violet fill)
- Sentiment breakdown: donut chart or horizontal stacked bar
- Meeting metrics grid: 4 stat cards (duration, words spoken, action items, decisions)

#### Analytics Page (Global)

**Overview cards (top row):**
- Meetings this week/month
- Total action items (open vs completed)
- Average engagement score (trend arrow)
- Average meeting duration (trend arrow)

**Charts:**
- Meeting frequency over time (bar chart, by week)
- Action item completion rate (line chart, by week)
- Top speakers by talk time (horizontal bar)
- Sentiment trend across meetings (line chart)

#### Settings Page
- Profile (name, email, avatar)
- Team management (invite users, manage roles) — enterprise feature
- Integrations (Slack, email, calendar connection status)
- Notification preferences
- Billing & Plan

#### Join Meeting Modal
- Triggered from sidebar button or meetings page
- Dark overlay, centered modal (max-w-md)
- Input: Meeting URL (required, URL validation)
- Input: Meeting title (optional)
- Platform auto-detected from URL, shown as badge
- "Send Bot" button (violet, loading state: "Deploying Bot...")
- Info note: "Supports Zoom, Google Meet & Microsoft Teams"

---

### 2.3 Auth Pages

**Shared layout:** Centered card on dark background, subtle gradient glow behind the card, logo above.

#### Sign Up
- Headline: "Start capturing every meeting"
- Fields: Full name, Work email, Password (with strength indicator), Company name (optional)
- CTA: "Create Account" (violet, full-width)
- Divider: "or continue with"
- OAuth buttons: Google, Microsoft (outline style)
- Footer: "Already have an account? Sign in"

#### Login
- Headline: "Welcome back"
- Fields: Email, Password
- "Forgot password?" link
- CTA: "Sign In" (violet)
- OAuth buttons
- Footer: "Don't have an account? Start free trial"

#### Forgot Password
- Headline: "Reset your password"
- Field: Email
- CTA: "Send Reset Link"
- Success state: "Check your email for a reset link"

---

### 2.4 Pricing Page

**Header:**
- Headline: "Simple pricing for every team"
- Subheadline: "Start free. Scale when you're ready."

**Pricing toggle:** Monthly / Annual (annual shows "Save 20%" badge)

**3 plan cards side-by-side:**

| | Starter (Free Trial) | Pro | Enterprise |
|---|---|---|---|
| **Price** | $0 for 14 days | $29/mo per user | $600/mo (up to 20 users) |
| **Meetings** | 5 meetings total | Unlimited | Unlimited |
| **Features** | AI notes, action items, transcripts | Everything in Starter + team sharing, analytics, integrations | Everything in Pro + dedicated setup, priority support, custom integrations, SSO |
| **CTA** | "Start Free Trial" (outline) | "Get Started" (violet solid) | "Contact Sales" (cyan outline) |
| **Note** | No credit card required | Most popular (badge) | Setup fee applies |

**Enterprise section below cards:**
- Full-width dark elevated card
- "Built for organizations that run on meetings"
- Feature grid: SSO/SAML, dedicated onboarding, custom integrations, SLA, volume discounts, admin dashboard
- CTA: "Talk to Sales" + "Book a Demo"

**FAQ section:**
- Accordion-style, 6-8 common questions
- "What happens after my trial?" / "Can I change plans?" / "How does the bot appear in meetings?" / etc.

---

## 3. Responsive Behavior

### Breakpoints
- **Mobile:** < 768px
- **Tablet:** 768px - 1024px
- **Desktop:** > 1024px

### Marketing page
- Hero stacks vertically on mobile, headline drops to 40px
- Feature blocks stack (image above text)
- Pricing cards stack vertically
- 3-step flow becomes vertical timeline

### Dashboard
- **Mobile:** Sidebar collapses to bottom tab bar (4 tabs: Actions, Meetings, Analytics, Settings)
- **Tablet:** Sidebar collapses to icon-only rail (56px), expands on hover
- **Desktop:** Full sidebar (240px)
- Meeting detail tabs become horizontally scrollable on mobile
- Action item rows simplify (owner + priority inline, due date below)

---

## 4. Accessibility

- All interactive elements keyboard-navigable with visible focus rings (violet outline)
- ARIA landmarks on all major sections (nav, main, aside)
- Color is never the only indicator (badges have text labels, not just colors)
- Minimum AA contrast on all text (verified against dark backgrounds)
- `prefers-reduced-motion`: all animations disabled, instant transitions
- Screen reader labels on all icon-only buttons
- Focus trap in modals
- Skip-to-content link

---

## 5. Key Interactions & Animations

### Landing Page
- Hero text: staggered word-by-word fade-in (0.05s per word)
- Product screenshot: fade-up + subtle scale from 0.95 to 1.0
- Stat counters: animated count-up on scroll intersection
- Feature blocks: fade-in-left / fade-in-right alternating on scroll
- How-it-works cards: stagger fade-up, 0.15s delay between cards
- CTA buttons: subtle glow pulse on hover

### Dashboard
- Sidebar nav: icon + text slide transition on collapse/expand
- Action item checkbox: scale bounce (1.0 → 1.2 → 1.0) + violet fill
- Meeting cards: lift shadow on hover (0.2s ease)
- Tab switching: content crossfade (0.2s)
- Join Meeting modal: backdrop fade + card scale-up from 0.95
- Status badges: pulse animation on "Recording" state
- Charts: draw-in animation on mount

---

## 6. Technical Architecture

### Next.js App Router Structure
```
app/
├── (marketing)/
│   ├── page.tsx              # Landing page
│   ├── pricing/page.tsx      # Pricing page
│   └── layout.tsx            # Marketing layout (no sidebar)
├── (auth)/
│   ├── login/page.tsx
│   ├── signup/page.tsx
│   ├── forgot-password/page.tsx
│   └── layout.tsx            # Auth layout (centered card)
├── (dashboard)/
│   ├── layout.tsx            # Dashboard layout (sidebar + main)
│   ├── page.tsx              # Action Items (home)
│   ├── meetings/
│   │   ├── page.tsx          # Meetings list
│   │   └── [id]/page.tsx     # Meeting detail
│   ├── analytics/page.tsx
│   └── settings/page.tsx
├── layout.tsx                # Root layout (fonts, providers)
├── globals.css               # Tailwind + custom tokens
└── not-found.tsx
```

### Key Libraries
- `next` 14+ (App Router)
- `tailwindcss` 3.4+
- `framer-motion` (scroll animations, page transitions, micro-interactions)
- `recharts` or `@tremor/react` (dashboard charts)
- `next-auth` (authentication)
- `react-hot-toast` (notifications)
- `lucide-react` (icons — clean, consistent)

### API Integration
- All API calls via server actions or route handlers proxying to the Express backend
- Meeting data fetched server-side where possible (SSR for SEO on marketing, SSG for pricing)
- Dashboard pages use client-side fetching with SWR or React Query for real-time updates
- WebSocket consideration for live meeting status updates (future)

---

## 7. Summary

**Product:** Meeting Assistant — enterprise AI meeting notes SaaS
**Visual:** Bold, dark, vibrant (The Command Center). Violet + cyan accents on deep dark surfaces.
**Pages:** Marketing landing, Pricing, Auth (login/signup/forgot), Dashboard (action items, meetings, meeting detail, analytics, settings)
**Stack:** Next.js + Tailwind + Framer Motion
**Differentiator:** Action-items-first dashboard, enterprise positioning ($600/mo), premium visual density
**Pricing:** Free Trial (5 meetings) → Pro ($29/mo/user) → Enterprise ($600/mo, 20 users, setup fee)
