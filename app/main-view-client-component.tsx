"use client"

import { useRelayEnvironment } from "react-relay"
import MainView from "src/components/main-view"
import { SerializablePreloadedQuery } from "src/relay/load-serializable-query"
import useSerializablePreloadedQuery from "src/relay/use-serializable-preloaded-query"
import MainViewQueryNode, { mainViewQuery } from "__generated__/mainViewQuery.graphql"

const MainViewClientComponent = (props: { preloadedQuery: SerializablePreloadedQuery<typeof MainViewQueryNode, mainViewQuery> }) => {
  const environment = useRelayEnvironment()
  const queryRef = useSerializablePreloadedQuery(environment, props.preloadedQuery)

  return <MainView queryRef={queryRef} />
}

export default MainViewClientComponent
