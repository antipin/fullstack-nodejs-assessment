<template>
  <div>
    <h1>Cocktails List</h1>
    <div v-if="loading">Loading...</div>
    <div v-else-if="error">{{ error }}</div>
    <div v-else>
      <label for="search">Search by description:</label>
      <input type="text" id="search" v-model="searchQuery" placeholder="Search..." />
      <ul>
        <li v-for="item in data" :key="item.id">
          <router-link :to="{ name: 'CocktailDetails', params: { id: item.id } }">
            <span style="font-weight: bold">{{ item.title }}</span> price: {{ item.price }}€
          </router-link>
        </li>
      </ul>
    </div>

  </div>
</template>

<script>
import { ref, watch, onMounted } from 'vue';
import debounce from 'lodash/debounce';

export default {
  name: 'NewCocktail',
  setup() {
    const searchQuery = ref('');
    const data = ref([]);
    const loading = ref(true);
    const error = ref(null);

    const fetchCocktails = debounce(async (query = '') => {
      try {
        const response = await fetch(`http://localhost:3000/cocktails?q=${encodeURIComponent(query)}`);
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const jsonData = await response.json();
        data.value = jsonData;
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    }, 300);

    watch(searchQuery, (newQuery) => fetchCocktails(newQuery));

    onMounted(fetchCocktails);

    return {
      data,
      loading,
      error,
      searchQuery,
    };
  },
};
</script>

<style scoped>
/* Add your styles here */
</style>