# Twitter Clone (Flutter)

This is a repository for TWITTER Clone with Flutter, Dart, AppWrite, Docker.

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
git clone https://github.com/nayak-nirmalya/twitter_clone_flutter.git
```

## Running Project

First, add your Moralis API Key to .env file as shown in .env.example file inside backend folder.

cd into 'backend' folder then start express server:

```bash
cd backend
npm install
npm run start
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Screenshots

### HomePagePreview

<img src="readme_imgs/login_signup.png" width="480">

### SearchResultPreview

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
