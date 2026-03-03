# Tech stack for the project

## Language

TypeScript for type safety.

## Framework

We chose Next.js as it is popular, good support for serverless and local hosting.
In addition it has support for server side rendering and lets us write
backend and frontend in the same language.

## Styling

We chose TailwindCSS to make styling faster.
We chose shadcn as our component library, it comes with styled components that
save time at the beginning but at the same time allow us to create our own style
later.

## Data Storage

We chose SupaBase as our data storage solution as it let's us easily
store files as well as structured data like login information.
It also allows us to choose between local and serverless hosting.

In addition we want to use DrizzleORM. It allows use to easily create data types
as well as ensure type safety between the web app and the database.
It also helps us with migrations.

## Authentication

BetterAuth
<https://github.com/better-auth/better-auth>
Free, works with SupaBase and drizzle, allows for Google Auth which is the
preferred option.

## Testing

Look at jest with next and RTS.
Jest: <https://nextjs.org/docs/app/guides/testing/jest>
RTS: <https://testing-library.com/docs/react-testing-library/intro/>

Playwright for in browser testing

Look at MSW for mocking APIs
<https://mswjs.io/docs/>
