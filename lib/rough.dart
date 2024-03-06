// FileManager(
// controller: controller, // Make sure controller is properly initialized
// builder: (context, snapshot) {
// final List<FileSystemEntity> entities = snapshot;
// return GridView.builder(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2, // Adjust the cross axis count as needed
// crossAxisSpacing: 2,
// mainAxisSpacing: 2,
// ),
// padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
// itemCount: entities.length,
// itemBuilder: (context, index) {
// FileSystemEntity entity = entities[index];
// return Card(
// child: ListTile(
// onTap: () {
// if (FileManager.isDirectory(entity)) {
// controller.openDirectory(entity);
// } else {
// // Handle file tap
// String filePath = entity.absolute.path;
// if (FileManager.isFile(entity)) {
// // Check if the file is an image or video
// if (filePath.endsWith('.jpeg') ||
// // filePath.endsWith('.jpeg') ||
// // filePath.endsWith('.png') ||
// filePath.endsWith('.gif') ||
// filePath.endsWith('.bmp')) {
// // Handle image
// // You can open the image using any image viewer or widget
// Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer(imagePath: filePath)));
// } else if (filePath.endsWith('.mp4') ||
// filePath.endsWith('.avi') ||
// filePath.endsWith('.mov') ||
// filePath.endsWith('.mkv')) {
// // Handle video
// // You can open the video using any video player or widget
// Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerWidget(videoPath: filePath)));
// } else {
// // Handle other file types
// // You can open or handle other types of files here
// }
// }
// }
//
// },
// leading: FileManager.isFile(entity)
// ? const Icon(Icons.feed_outlined)
//     : const Icon(Icons.folder),
// title: Text(FileManager.basename(
// entity,
// showFileExtension: true,
// )),
// subtitle: subTitle(entity),
// ),
// );
// },
// );
// },
// ),
