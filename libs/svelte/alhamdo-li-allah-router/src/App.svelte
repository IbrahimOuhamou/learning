<script>
  // import type { Route } from "@mateothegreat/svelte5-router";
  import { route, Router } from "@mateothegreat/svelte5-router";
  import HomePage from './lib/HomePage.svelte';
  import Params from './lib/Params.svelte';
  import About from './lib/About.svelte';

  const routes = [
    {
      path: "^/$",
      component: HomePage
    },
    {
      path: "about",
      component: About
    },
    {
      path: "/params/(?<route>.*)/(?<subhana_allah>.*)",
      // path: "params",
      component: Params
    },
  ];
</script>

<div class="flex gap-2">
  <a use:route href="/">Home</a>
  <a use:route href="/about">About</a>
  <a use:route href="/params/2">/params/2</a>
</div>

<p class="text-green-800">la ilaha illa Allah Mohammed Rassoul Allah</p>

<Router basePath="/" {routes} />

