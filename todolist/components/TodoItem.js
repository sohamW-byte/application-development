import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

export default function TodoItem({ item, onToggle, onDelete }) {
  return (
    <View style={styles.row}>
      <TouchableOpacity onPress={onToggle} style={[styles.checkbox, item.done && styles.checked]}>
        {item.done ? <Text style={styles.checkMark}>✓</Text> : null}
      </TouchableOpacity>

      <Text style={[styles.text, item.done && styles.textDone]}>{item.text}</Text>

      <TouchableOpacity onPress={onDelete} style={styles.delete}>
        <Text style={styles.deleteText}>Delete</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  row: { flexDirection: 'row', alignItems: 'center', padding: 10, backgroundColor: '#fff', borderRadius: 8, marginBottom: 8, borderWidth: 1, borderColor: '#ececec' },
  checkbox: { width: 28, height: 28, borderRadius: 6, borderWidth: 1, borderColor: '#999', alignItems: 'center', justifyContent: 'center', marginRight: 12 },
  checked: { backgroundColor: '#2e86de', borderColor: '#2e86de' },
  checkMark: { color: '#fff', fontWeight: '700' },
  text: { flex: 1, fontSize: 16 },
  textDone: { textDecorationLine: 'line-through', color: '#888' },
  delete: { marginLeft: 12, paddingHorizontal: 8, paddingVertical: 4 },
  deleteText: { color: '#e74c3c' }
});
