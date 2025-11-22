package com.example.myapplication // FIXED: Changed package name to match your file path (myapplication)

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.ui.text.font.FontWeight
import com.example.myapplication.ui.theme.MyApplicationTheme // FIXED: Changed theme import to match your project package

// The main activity class is the entry point for the Android app
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Set the content using Jetpack Compose
        setContent {
            // Apply the app's theme (using the corrected theme name)
            MyApplicationTheme {
                // Display the main screen of the counter application
                CounterScreen()
            }
        }
    }
}

/**
 * Main Composable function that defines the structure and behavior of the counter screen.
 */
@Composable
fun CounterScreen() {
    // 1. State Management:
    // Uses mutableIntStateOf (recommended best practice for Int)
    var count by remember { mutableIntStateOf(0) }

    // Surface is a composable that draws a background and provides default theme colors
    Surface(
        modifier = Modifier.fillMaxSize(),
        color = MaterialTheme.colorScheme.background
    ) {
        // Column arranges its children vertically in the center
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            // Title Text
            Text(
                text = "Compose Counter",
                style = MaterialTheme.typography.headlineLarge,
                modifier = Modifier.padding(bottom = 32.dp)
            )

            // 2. Count Display:
            // Display the current count value with a large font size
            Text(
                text = "$count",
                fontSize = 120.sp,
                fontWeight = FontWeight.ExtraBold,
                color = MaterialTheme.colorScheme.primary,
                modifier = Modifier.padding(bottom = 48.dp)
            )

            // 3. Control Buttons:

            // Increment Button
            Button(
                onClick = { count++ }, // Logic to increment the state
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                shape = MaterialTheme.shapes.medium
            ) {
                Text(
                    text = "Increment",
                    fontSize = 20.sp
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            // Reset Button
            Button(
                onClick = { count = 0 }, // Logic to reset the state
                // Button is only enabled if the count is not zero
                enabled = count != 0,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(60.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = MaterialTheme.colorScheme.error,
                    disabledContainerColor = MaterialTheme.colorScheme.error.copy(alpha = 0.5f)
                ),
                shape = MaterialTheme.shapes.medium
            ) {
                Text(
                    text = "Reset",
                    fontSize = 20.sp
                )
            }
        }
    }
}

// Preview function to display the Composable in the Android Studio design pane
@Preview(showBackground = true)
@Composable
fun CounterPreview() {
    MyApplicationTheme { // FIXED: Using the corrected theme name
        CounterScreen()
    }
}
