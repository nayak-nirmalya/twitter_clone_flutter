# Twitter Clone (Flutter)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

Its a clone of Etherscan.

## Running Project

First, add your Moralis API Key to .env file as shown in .env.example file inside backend folder.

cd into 'backend' folder then start express server:

```bash
cd backend
npm install
npm run start
```

open another terminal window and navigate to 'frontend' folder to run Next.js:

```bash
cd frontend
npm install
npm run dev
```

to build, run:

```bash
cd frontend
npm install
npm run build
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Screenshots

### HomePagePreview

![HomePage](reademe-images/HomePage.png)

### SearchResultPreview

![SearchResult](reademe-images/SearchResult.png)

# TWITTER Clone with React, Tailwind, Next, Prisma, Mongo, NextAuth, TypeScript & Vercel

This is a repository for a FullStack Twitter Clone using React, NextJS, TailwindCSS & Prisma.

Funcionalities:

- Authentication via E-Mail & Password
- AppWrite Backend Server
- Notification system
- Image Upload
- Responsive Layout
- 1 To Many Relations (User - Post)
- Many To Many Relations (Post - Comment)
- Following functionality
- Comments / Replies
- Search by HashTags
- View Link Preview inside Posts
- Search User
- RealTime Updates
- DataBase Queries
- Editing Profile Details including Profile/Banner Picture
- Twitter Blue Verification Tag

### Prerequisites

**Flutter SDV ^= 3.7.9**

**Docker (for AppWrite)**

**Android Studio / XCode (Virtual Device Simulation)**

**VS Code (IDE)**

### Cloning the repository

```shell
git clone https://github.com/nayak-nirmalya/twitter-clone.git
```

### Install packages

```shell
npm i
```

### Setup .env file

```js
DATABASE_URL=
NEXTAUTH_JWT_SECRET=
NEXTAUTH_SECRET=
```

### Start the app

```shell
npm run dev
```

## Available commands

Run Prisma Studio

```shell
npx prisma studio
```

Running Commands with NPM `npm run [command]`

| command | description                              |
| :------ | :--------------------------------------- |
| `dev`   | Starts a development instance of the app |
| `build` | Build instance of the app                |
| `start` | Run Build instance of the app            |
