<script>
	import { Button } from "$lib/components/ui/button/index";
	import { Badge } from "$lib/components/ui/badge/index";
	import { Calendar } from "$lib/components/ui/calendar/index";
	let value = $state('');
</script>
<h1 class="text-2xl">بسم الله الرحمن الرحيم</h1>
<p>
	la ilaha illa Allah Mohammed Rassoul Allah
</p>


<Button size="lg">
	بسم الله الرحمن الرحيم
</Button>
<Badge>badge</Badge>
<Calendar bind:value={value} />
<Badge>{value}</Badge>
