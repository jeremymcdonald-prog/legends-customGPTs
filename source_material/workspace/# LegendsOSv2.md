\# LegendsOSv2.0 Handoff, Jeremy Applicants Pipeline And Loan Factory Loan Brain

\#\# Purpose

This handoff explains how LegendsOSv2.0 should connect to and use Jeremy McDonald's Google Drive based mortgage operations folder for live loan workflow, processor handoff, underwriting guideline research, and Ashley processing support.

This folder is not just document storage. It should become the shared working source for Jeremy, Ashley, Geraldine, Codex, and LegendsOSv2.0.

\#\# Primary Google Drive Folder

Folder name:

Jeremy Applicants Pipeline

Google Drive folder link:

https://drive.google.com/drive/folders/1X8BD29eHIzK9TJOssKB1hq3EH-Y1H7mW?usp=sharing

This is the main Google Drive synced working folder that Codex is currently working inside.

LegendsOSv2.0 should treat this folder as the main file workspace for Jeremy's mortgage pipeline, borrower files, processing handoffs, guideline references, and Loan Factory support resources.

\#\# Current Folder Structure

The folder currently includes:

ACTIVE LOANS

LEADS

PROSPECTS

PAST CLIENTS

FLO\_OS\_FULL\_BUILD\_HANDOFF

Loan Factory Resources

UW Guides

TITLE Legends Master Pipeline Source Document UPDATED.md

Jeremy Pipeline Output Formatting Rules.md

Jeremy Master Persona Output Addendum.md

Codex is creating a new folder inside this same workspace called:

Loan Factory Loan Brain

\#\# Existing Folder Roles

ACTIVE LOANS is the live workspace for loans currently in process.

LEADS is for new lead activity.

PROSPECTS is for borrowers or referral opportunities that are not yet active loans.

PAST CLIENTS is for closed, historical, or archived client relationships.

Loan Factory Resources is the shared company resource folder.

UW Guides is the raw underwriting guideline source folder.

FLO\_OS\_FULL\_BUILD\_HANDOFF is the correct place for LegendsOSv2.0 handoff docs, implementation notes, prompts, and build instructions.

Loan Factory Loan Brain is the new knowledge and workflow engine Codex is creating.

\#\# UW Guides Source Documents

The UW Guides folder currently includes these underwriting source documents:

Fannie Mae Selling Guide 05 06 26 highlighted FINAL.pdf

FHA UW 4000.1 hsg update16 5.pdf

Freddie Mac Selling Guide.pdf

Non QM Hand book v2.pdf

USDA Originator RHS HB 1 3560 consolidated.pdf

USDA RHS Consolidated HB 1 3555.pdf

VA guidelines are not currently visible in the folder and should be added later.

Recommended VA additions:

VA Lenders Handbook

VA Circulars

VA appraisal and Tidewater guidance

VA IRRRL guidance

VA cash out refinance guidance

\#\# Codex Current Assignment

Codex is creating a structured Loan Factory Loan Brain inside the existing Jeremy Applicants Pipeline folder.

Codex should create:

Loan Factory Loan Brain README.md

Agency guideline source index

Loan program knowledge packs

Scenario risk checklist

Lender overlay workflow

Ask the AE trigger list

Processor handoff template

Ashley new file email template

Condition response builder

Pipeline to Loan Brain bridge

3 point 4 intake workflow

Future lender master index placeholder

Build log

\#\# LegendsOSv2.0 Integration Goal

LegendsOSv2.0 should use this Drive folder as a connected mortgage operating workspace.

The app should eventually allow Jeremy and authorized users to:

View borrower folders

Upload borrower documents

Read and summarize 3 point 4 files

Read AUS findings

Create processor handoff documents

Generate Ashley handoff emails

Track missing documents

Create underwriting condition response plans

Search agency guidelines

Search Loan Factory resources

Identify lender overlay risk

Prepare Ask the AE emails

Update pipeline notes

Link active loans to Drive folders

Support Ashley and Geraldine without requiring Jeremy to manually organize every file

\#\# Ashley Use Case

Ashley should be able to receive a clean file handoff that includes:

Borrower name

Loan number

Loan program

Loan purpose

Property address

Lender

TPO portal link

AE contact

Account manager contact

Support desk contact

Realtor contact

Title contact

HOI contact

Fannie Mae 3 point 4 file

AUS findings

Documents received

Documents missing

Known conditions

Known risks

Priority next steps

Google Drive borrower folder link

LegendsOSv2.0 should help create this handoff from uploaded files, screenshots, loan notes, and Drive contents.

\#\# Geraldine Use Case

Geraldine should be able to use the folder and LegendsOSv2.0 to help with:

Lead follow up

Document collection

Borrower status tracking

Missing item follow up

Pipeline updates

Drive folder organization

Basic borrower communication drafts

Escalating urgent items to Jeremy

\#\# Jeremy Use Case

Jeremy should be able to drop in:

Screenshots

3 point 4 files

AUS findings

Lender screenshots

Pricing screenshots

Title emails

HOI emails

Borrower docs

Underwriting conditions

Loan notes

Then LegendsOSv2.0 should help create:

A clean loan summary

A processor handoff

A borrower missing item list

A condition response plan

An Ashley email

A lender overlay risk note

A pipeline update

A Drive folder organization recommendation

\#\# File Handling Rules

Do not rename or move core pipeline folders unless Jeremy specifically asks.

Do not delete original PDFs, spreadsheets, or borrower documents.

Do not overwrite verified loan data with weaker notes.

Do not invent borrower data.

Do not invent guideline citations.

Do not assume agency guideline approval means lender approval.

Keep raw source documents in their current folders.

Create clean working markdown files inside Loan Factory Loan Brain.

Borrower specific documents should stay inside the correct borrower folder under ACTIVE LOANS, LEADS, PROSPECTS, or PAST CLIENTS.

\#\# Recommended Borrower Folder Structure

For active loans, use this structure when available:

00\_LOAN\_OVERVIEW

01\_INCOME\_ASSETS

02\_DISCLOSURES

03\_APPRAISAL\_TITLE\_INSURANCE

04\_CONDITIONS\_SUBMIT\_TO\_UW

05\_CLOSING

06\_FINAL

Customer Team Uploads

Customer Team Uploads should be the first stop for documents received by Jeremy, Ashley, Geraldine, or any team member.

\#\# Lender Overlay Workflow

When a lender is assigned, LegendsOSv2.0 should help check:

Lender name

Loan program

Scenario risks

Product matrix

Lender overlays

Recent announcements

AE contact

Account manager contact

Support desk

TPO portal

Known lender issues

When to ask the AE before submission

The lender list has been requested and will be added later.

Until then, the app should allow lender data to be entered manually from screenshots, emails, portal notes, or Jeremy's instructions.

\#\# Future Lender Master Index

When Jeremy receives the lender list, add it to:

Loan Factory Loan Brain

09 Future Lender Master Index

The lender master index should track:

Lender name

TPO portal link

Programs offered

FHA

VA

USDA

Conventional

Non QM

DSCR

Bank statement

Foreign national

Construction

Land

Commercial

AE name

AE email

AE phone

Account manager

Support desk

Lock desk

Underwriting fee

Appraisal process

Known overlays

Best use case

Known problems

Last verified date

Notes

\#\# Important Build Direction

Do not turn this into a complicated compliance gate system.

The first goal is simple:

Connect LegendsOSv2.0 to the Drive folder.

Read the folder structure.

Let Jeremy select or search a borrower.

Let the app pull file context.

Let the app generate clean handoffs, document requests, condition responses, and Ashley processing emails.

The second goal is to connect the Loan Factory Loan Brain so the app can answer guideline and scenario questions from approved source documents.

The third goal is to add lender overlay intelligence after the lender list arrives.

\#\# Initial LegendsOSv2.0 Features To Build

1\. Google Drive borrower file browser

2\. Active loan file search

3\. Borrower folder summary

4\. Document received and missing item tracker

5\. Processor handoff generator

6\. Ashley email generator

7\. 3 point 4 intake parser

8\. AUS summary reader

9\. Underwriting condition response builder

10\. Guideline search from UW Guides and Loan Factory Loan Brain

11\. Lender overlay note creator

12\. Pipeline update assistant

\#\# Environment And Access Notes

The Google Drive folder is the working source.

Use Google Drive connector access where available.

Use Gmail integration for Ashley handoff email drafts when available.

Use Google Sheets integration for pipeline updates when available.

If direct write access is not available, generate clean copy ready outputs for Jeremy.

Do not require Jeremy to manually perform technical file setup that Codex or the app can perform.

\#\# Final Build Principle

This should work like Jeremy's mortgage command center.

Jeremy should be able to say what happened on a file, upload a few screenshots or documents, and LegendsOSv2.0 should organize the information, identify what matters, create the processor handoff, prepare the next communication, and keep the file moving.  
