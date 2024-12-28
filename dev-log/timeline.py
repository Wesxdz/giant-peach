import os
import time
import matplotlib.pyplot as plt
from matplotlib.offsetbox import OffsetImage, AnnotationBbox
from PIL import Image

# Get file information
file_info = []
for file in os.listdir("."):
    if os.path.isfile(file):
        creation = time.ctime(os.path.getctime(file))
        file_info.append((file, creation))

# Sort files by creation date
file_info.sort(key=lambda x: time.strptime(x[1]))

# Prepare the timeline plot
fig, ax = plt.subplots(figsize=(12, 6))
y_pos = 1  # Single row for timeline
x_positions = range(len(file_info))  # Evenly spaced x positions

# Add thumbnails/icons for each file
for idx, (file, creation) in enumerate(file_info):
    x = x_positions[idx]
    ax.text(x, y_pos + 0.2, file, ha='center', fontsize=8)  # File name above
    ax.text(x, y_pos - 0.4, creation, ha='center', fontsize=6, color='gray')  # Date below
    
    try:
        # Generate a thumbnail for image files
        if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif')):
            img = Image.open(file)
            img.thumbnail((50, 50))  # Resize for thumbnail
            imagebox = OffsetImage(img, zoom=0.5)
        else:
            # Placeholder icon for non-image files
            icon = Image.new("RGB", (50, 50), color=(200, 200, 200))  # Gray box
            imagebox = OffsetImage(icon, zoom=0.5)
        
        ab = AnnotationBbox(imagebox, (x, y_pos), frameon=False)
        ax.add_artist(ab)
    except Exception as e:
        print(f"Could not process {file}: {e}")

# Adjust plot
ax.set_xlim(-1, len(file_info))
ax.set_ylim(0.5, 1.5)
ax.axis('off')  # Hide axes

plt.title("File Creation Timeline")
plt.show()
