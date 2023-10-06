import { Suspense } from "react"

export default function AffiliateView(props: { data: object }) {

  return <Suspense fallback="Loading (client side)...">
    <span>
      Please copy your affiliate link below
    </span>
    <div>
      {JSON.stringify(props.data)}
    </div>
  </Suspense>
}
