#Using Debian stable
FROM node:alpine
 
# Copy the package.json file to the image
COPY package.json package.json
# COPY app.json app.json
# Install required packages
RUN npm install
  
# Copy any other necessary files
COPY . .
 
# Command to run the program
CMD ["npm", "start"]
#CMD ["sleep", "3000"]