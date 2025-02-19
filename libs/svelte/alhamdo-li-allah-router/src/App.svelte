<script>
  // import type { Route } from "@mateothegreat/svelte5-router";
  import { route, Router } from "@mateothegreat/svelte5-router";
  import HomePage from './lib/HomePage.svelte';
  import About from './lib/About.svelte';

  const routes = [
    {
      path: "/",
      component: HomePage
    },
    {
      path: "about",
      component: About
    },
  ];
</script>

<div class="flex gap-2">
  <a use:route href="/">Home</a>
  <a use:route href="/about">About</a>
</div>

<p class="text-green-800">la ilaha illa Allah Mohammed Rassoul Allah</p>

<Router base="/" {routes} />

