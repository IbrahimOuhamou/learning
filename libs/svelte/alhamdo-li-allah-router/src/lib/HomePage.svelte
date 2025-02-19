<script>
  import { route, Router } from "@mateothegreat/svelte5-router";
</script>
<p>Home</p>

<a use:route href="/about">About</a>
<a use:route href="/params/1">/param/1</a>
<a use:route href="/params/2">/param/2</a>
