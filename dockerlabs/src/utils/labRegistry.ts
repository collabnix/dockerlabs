import { Lab } from '@/types/lab';
import { helloWorldLab } from '@/labs/beginners/hello-world';
import { dockerImagesLab } from '@/labs/beginners/docker-images';

export const labRegistry: Record<string, Lab> = {
  'docker-hello-world': helloWorldLab,
  'docker-images-basics': dockerImagesLab,
};

export const getLabById = (id: string): Lab | undefined => {
  return labRegistry[id];
};

export const getLabsByCategory = (category: string): Lab[] => {
  return Object.values(labRegistry).filter(lab => lab.category === category);
};

export const getAllLabs = (): Lab[] => {
  return Object.values(labRegistry);
};

export const getFeaturedLabs = (): Lab[] => {
  return Object.values(labRegistry).filter(lab => lab.featured);
};
