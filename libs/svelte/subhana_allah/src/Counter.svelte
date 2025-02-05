<script>
    // بسم الله الرحمن الرحيم
    // la ilaha illa Allah Mohammed Rassoul Allah

    import { counter } from './shared.svelte.js';

    function increment() {
        counter.count += 1;
    }

    let { bg_color = 'bg-indigo-300' } = $props();
</script>

<button onclick={increment} class="{bg_color} p-2 rounded-md block text-gray-400">
    subhana Allah counter: {counter.count}
</button>
