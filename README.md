# Affiliation System Example (with Next.js 13.5)

## Overview

This is a demo example of an Affiliation System:

- Uses App Router and Route Handlers vs (legacy at this stage?) API Routes.

- Uses the React Server Components (Next.js v13) as entry points for [fetching](https://beta.nextjs.org/docs/data-fetching/fetching) root queries.

  - `loadSerializableQuery` reference implementation of the data-fetching method that can be used in the RSC
  - `useSerializablePreloadedQuery` an example hook that can convert serialized query results into preloaded query.

- Uses React-Relay [GraphQL client] (https://github.com/facebook/relay).

- GraphQL server is Hasura over PostreSQL

- Has TypesScript Setup.

## Relay Data flow

The query fetching is happening in the `page.tsx` async server component that is calling `loadSerializableQuery`. Then, preloaded results are passed to the root client component (`MainViewClientComponent`, for example). These preloaded results are converted into Relay's `PreloadedQuery` object, which is passed to the root Relay component that renders the query with the `usePreloadedQuery` hook.


## Installation

1. npm install
2. npm run relay
3. npm run build
4. npm start
5. open http://localhost:3000 
