<!-- بسم الله الرحمن الرحيم -->
<!-- la ilaha illa Allah Mohammed Rassoul Allah -->

<script>
    import MyButton from './MyButton.svelte';
    import Effects from './Effects.svelte';

    let count = $state(0);
    function increment() {
        count += 1;
    }
    let multiple = $derived(count * 2);
    
    // logs value on change, similar to
    // `console.log($state.snapshot(count))`
    $inspect(count);
    // can also do
    // $inspect(count).with(console.trace);
</script>

<main>
    <MyButton />
    <button onclick={increment}>
        {count}
    </button>
    <p>{multiple}</p>
    <Effects />
</main>

<style>
</style>

