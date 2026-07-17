# Example 02 — Mortgage Marketing Campaign Review

## Input

> Review this mortgage campaign: a Facebook + email push on the $1,000 Lowest Rate & Fee Guarantee for Northeast Florida buyers who already got a bank quote.

## Output

**1. EXECUTIVE VERDICT**
Fix-then-ship. The audience targeting is sharp and the offer is real, but the campaign will fail compliance the moment it goes live unless three specific guardrails are in place. Get those in, this is one of Jeremy's strongest conversion plays.

**2. BOARDROOM WORKFLOW SELECTED**
Workflow 3 — Mortgage Marketing Campaign Review. Strategy Council plus mandatory Compliance, Borrower Privacy, External-Send Approval, NMLS Disclosure, Owner Approval checks.

**3. ADVISOR SEAT REVIEWS**
- **Offer Seat:** the value equation is clean. Existing bank quote + $1,000 guarantee creates a concrete, falsifiable promise that converts. Strong.
- **Tribe Seat:** "buyers who already got a bank quote" is one of the highest-intent audiences in mortgage. Right people.
- **Behavior Seat:** the fear is being stuck with a worse deal. The promise reframes the cost of inaction. Works.
- **Compliance Seat:** the guarantee has hard rules. Current confirmed amount only. Washington is excluded. T&C URL required. Not-a-commitment-to-lend disclaimer required. NMLS #320841 must be complete. Without these, this campaign cannot publish.
- **Cash Seat:** the unit economics depend on close rate vs payout exposure. Sanity-check whether the current confirmed amount + the conversion lift covers payout risk.
- **Simplicity Seat:** Facebook + email is the right starting surface. Don't add channels until this one is dialed.

**4. POINTS OF AGREEMENT**
Audience and offer are both right. The campaign should run.

**5. POINTS OF CONFLICT**
None at the strategy level. All conflict is between Compliance and execution speed. Compliance wins; the speed problem is solved by having the assets compliance-correct on day one.

**6. HIDDEN RISKS**
- Tier 2 Yellow (public marketing).
- R4 triggered if any version of the creative ships without the required T&C URL, eligible-states line, or full NMLS.
- R10 not applicable (no auto-send beyond standard scheduled email).
- Borrower privacy: do NOT collect bank-quote screenshots that contain PII as part of the offer flow without a redaction step.

**7. BEST OPPORTUNITY**
The "show me your bank quote, I'll show you mine" mechanic is a content series in itself. Run the campaign, then turn the best stories (with consent) into testimonial creatives for the next quarter.

**8. RECOMMENDED DECISION**
Fix-then-ship.

**9. PRIORITY FIXES (ranked)**
1. Confirm current `current_guarantee_offer` value and `eligible_states` (excluding Washington) before any creative ships. If unset, the compliance gate blocks the campaign.
2. Every creative (FB post, FB ad variant, email body, email footer) must carry: $ amount, "All states except Washington," T&C URL, not-a-commitment-to-lend line, NMLS #320841 verified complete, NMLS #1195266, Equal Housing Lender.
3. Add a PII redaction step in the intake flow: borrowers do not upload bank quote screenshots; they paste the rate, APR, and fee detail into a form field with a redaction reminder.
4. The email must include a working unsubscribe link and the verified business mailing address (CAN-SPAM).
5. Geo-targeting: exclude Washington at the platform level on every paid placement. Belt + suspenders.

**10. FINAL ACTION PLAN**
- Today: confirm guarantee value, eligible states, and T&C URL with the verified config. Update `_shared/brand-dna/guarantee-terms.md` if anything has drifted.
- This week: build the four creatives (FB post, FB ad, email body, landing page) with all five compliance elements. Route each through `visual-intelligence` for the asset gate before publish.
- Owner approval: get written sign-off from the campaign owner. Audit log + routing record on file before any send.
- Then ship.

Let me know what you'd like me to do next.
