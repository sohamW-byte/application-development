import React, { useState } from 'react';
import { SafeAreaView, View, Text, TextInput, TouchableOpacity, FlatList, StyleSheet, Alert } from 'react-native';
import TodoItem from './components/TodoItem';

export default function App() {
  const [text, setText] = useState('');
  const [todos, setTodos] = useState([]);

  const addTodo = () => {
    const trimmed = text.trim();
    if (!trimmed) return Alert.alert('Empty todo', 'Please enter a todo item');
    setTodos(prev => [{ id: Date.now().toString(), text: trimmed, done: false }, ...prev]);
    setText('');
  };

  const toggleTodo = id => {
    setTodos(prev => prev.map(t => t.id === id ? { ...t, done: !t.done } : t));
  };

  const deleteTodo = id => {
    setTodos(prev => prev.filter(t => t.id !== id));
  };

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>Todo List</Text>
      <View style={styles.inputRow}>
        <TextInput
          style={styles.input}
          placeholder="Add a todo"
          value={text}
          onChangeText={setText}
          onSubmitEditing={addTodo}
          returnKeyType="done"
        />
        <TouchableOpacity style={styles.addButton} onPress={addTodo}>
          <Text style={styles.addButtonText}>Add</Text>
        </TouchableOpacity>
      </View>

      <FlatList
        data={todos}
        keyExtractor={item => item.id}
        renderItem={({ item }) => (
          <TodoItem item={item} onToggle={() => toggleTodo(item.id)} onDelete={() => deleteTodo(item.id)} />
        )}
        ListEmptyComponent={<Text style={styles.empty}>No todos yet. Add one above.</Text>}
        contentContainerStyle={todos.length ? null : styles.emptyContainer}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, padding: 16, backgroundColor: '#f7f7f7' },
  title: { fontSize: 28, fontWeight: '700', marginBottom: 12, textAlign: 'center' },
  inputRow: { flexDirection: 'row', marginBottom: 12 },
  input: { flex: 1, backgroundColor: '#fff', paddingHorizontal: 12, paddingVertical: 10, borderRadius: 6, borderWidth: 1, borderColor: '#ddd' },
  addButton: { marginLeft: 8, backgroundColor: '#2e86de', paddingHorizontal: 14, justifyContent: 'center', borderRadius: 6 },
  addButtonText: { color: '#fff', fontWeight: '600' },
  empty: { textAlign: 'center', color: '#666' },
  emptyContainer: { flex: 1, justifyContent: 'center' }
});
