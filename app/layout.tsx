"use client"

import { RelayEnvironmentProvider } from "react-relay"
import { getCurrentEnvironment } from "src/relay/environment"
import "./globals.css" // These styles apply to every route in the application

export default function RootLayout({ children }: { children: React.ReactNode }) {
  const environment = getCurrentEnvironment()

  return <html>
    <head>
      <title>Affiliation System</title>
    </head>
    <RelayEnvironmentProvider environment={environment}>
      <body className="h-screen">{children}</body>
    </RelayEnvironmentProvider>
  </html>
}
